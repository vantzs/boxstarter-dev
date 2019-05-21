Boxstarter Install Script for BlueSentryIT Dev Box on Windows 10.  
This script is made with Powershell, Boxstarter (http://boxstarter.org/package/Boxstarter), and Chocolatey (https://chocolatey.org).  
This will take a untouched Windows 10 installation and install the following tools and configure the following changes.  

# Added Reboot Tests throughout Script
if (Test-PendingReboot) { Invoke-Reboot }  

# Windows Options:
Set-WindowsExplorerOptions -EnableShowFileExtenstions -EnableShowFullPathInTitleBar<br>
Enable-RemoteDesktop  
Enable-PSRemoting -Force  
Update-ExecutionPolicy RemoteSigned  
Disable-BingSearch  
Disable-GameBarTips 

# Removed Unecessary Windows Apps
3D Builder  
Alarms  
Autodesk  
Bing Weather, News, Sports, and Finances (Money)  
BubbleWitch  
CandyCrush  
DropBox  
Facebook  
Feedback Hub  
Get Started  
Keeper  
Mail & Calendar  
March of Empires  
McAfee Security  
Messaging  
Minecraft  
Netflix  
Office Hub  
One Connect  
OneNote  
People  
Phone  
Photos  
Plex  
Skype (Metro Version)  
Sound Recorder  
Sticky Notes  
Solitare  
Sway  
Twitter  
Xbox  
Zune Music, Movies, & TV  

# Tools:
powershell4  
SourceCodePro  
git-fork  
notepadplusplus  
SourceTree  
MsSqlServerManagementStudio2014Express  
sql-server-management-studio (Version 18)  
VisualStudio2013Professional -InstallArguments "WebTools"  
wsl-ubuntu-1804  
PyCharm  
Intelli J IdeaC
logparser  
fiddler4  
PhantomJS  
SysInternals  
GoogleChrome  
firefox  
lastpass  
Office365ProPlus  
Greenshot  
slack  
discord  
7zip  
teracopy  
foxitreader  
vlc  
cyberduck  
OptiPNG  
mremoteng  
flashplayerplugin  
AdobeAir  
javaruntime  
java.jdk  
nodejs  
golang  

# Windows Updates:  
Install-WindowsUpdate -AcceptEula

# Taskbar Items:  
Google Chrome  
Explorer  
Powershell  
Console  
Notepad++  

# VSIS Packages
Install-ChocolateyVsixPackage PowerShellTools http://visualstudiogallery.msdn.microsoft.com/c9eb3ba8-0c59-4944-9a62-6eee37294597/file/112013/6/PowerShellTools.vsix

# Filesystem
New-Item -Path C:\ -Name Temp -ItemType Directory

# Added Command at End of Script to rename and reboot the computer
$computername = "Stormbreaker"
if ($env:computername -ne $computername) {
	Rename-Computer -NewName $computername
}
if (Test-PendingReboot) { Invoke-Reboot }

# To Execute
http://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/vstock28021/boxstarter-dev/master/boxstarter-dev-config.ps1
