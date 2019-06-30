#Configure Server and Install Software
#Set Variables Block
#This keeps the script universal so it can be used on future deployments
param (
    [Parameter(Mandatory=$FALSE, HelpMessage="Activation Key")]
    [String]
    $activationkey,

    [Parameter(Mandatory=$TRUE, HelpMessage="New Computer Name")]
    [String]
    $newcomputername,
	
	[Parameter(Mandatory=$TRUE, HelpMessage="Office 365 Config path eg, 'ConfigPath:\\file-server\folder\sub-folder\config.xml'")]
    [String]
    $configpath,
	
	[Parameter(Mandatory=$TRUE, HelpMessage="Domain name")]
    [String]
    $domain,
	
	[Parameter(Mandatory=$TRUE, HelpMessage="Domain OU format ou=ouname,dc=domain,dc=tld ")]
    [String]
    $ou,
	
	[Parameter(Mandatory=$TRUE, HelpMessage="Domain Join Credentials domain\username ")]
    [String]
    $creds
)

#Info for Boxstarter
$Boxstarter.RebootOk=$true # Allow reboots?
$Boxstarter.NoPassword=$false # Is this a machine with no login password?
$Boxstarter.AutoLogin=$true # Save my password securely and auto-login after a reboot

#Create new folder for log
New-item -ItemType directory -Path C:\bsiadmin -Force
New-item -ItemType directory -Path C:\bsiadmin\logs -Force

#Start Logging
Start-Transcript -Path c:\bsiadmin\logs\conf-server-install-apps.txt

# Activate Windows
# Invoke-Command -ComputerName $env:computername -ScriptBlock { slmgr -ipk $activationkey }

#Rename Server
Rename-computer -newname $newcomputername

#Reboot for Rename
if (Test-PendingReboot  -SkipConfigurationManagerClientCheck) { Restart-Computer }

#Install Powershell Modules
Install-Module -name PendingReboot -Force

# Setting Time Zone
Set-TimeZone -Name "Eastern Standard Time"

# Set Windows power options
powercfg -change -standby-timeout-ac 0
powercfg -change -standby-timeout-dc 0

powercfg -h off

#Set some Misc. Options
Enable-PSRemoting –force
Set-Service WinRM -StartMode Automatic
Set-Item WSMan:localhost\client\trustedhosts -value *.$domain
Set-WindowsExplorerOptions -EnableShowFileExtensions -EnableShowFullPathInTitleBar
Set-StartScreenOptions -EnableBootToDesktop
Enable-RemoteDesktop

#Check for Pending Reboot
if (Test-PendingReboot  -SkipConfigurationManagerClientCheck) { Restart-Computer }

#Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#Install Some Apps
choco install foxitreader -y
choco install notepadplusplus -y
choco install greenshot -y
choco install 7zip -y
choco install GoogleChrome -y
choco install jre8 -y
choco install AdobeAir -y
choco install awscli -y
choco install awstools.powershell -y

#Install SSM
$url = "https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/windows_amd64/AmazonSSMAgentSetup.exe"
$output = "C:\bsiadmin\AmazonSSMAgentSetup.exe"
$start_time = Get-Date
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)
$ssminstall = {C:\bsiadmin\AmazonSSMAgentSetup.exe /S /v/qn}
Invoke-Command -ScriptBlock $ssminstall

#Join Domain
Add-Computer -DomainName $domain -OUPath $ou -Credential $creds -passthru -verbose

#Check for Pending Reboot
if (Test-PendingReboot  -SkipConfigurationManagerClientCheck) { Restart-Computer }

choco install office365proplus --params $configpath -y

#Check for Pending Reboot
if (Test-PendingReboot  -SkipConfigurationManagerClientCheck) { Restart-Computer }
