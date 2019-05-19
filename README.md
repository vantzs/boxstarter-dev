Boxstarter Install Script for BlueSentryIT Dev Box on Windows 10.  
This script is made with Powershell, Boxstarter (http://boxstarter.org/package/Boxstarter), and Chocolatey (https://chocolatey.org).  
This will take a untouched Windows 10 installation and install the following tools and configure the following changes.  

Set-WindowsExplorerOptions -EnableShowFileExtenstions -EnableShowFullPathInTitleBar<br>
Enable-RemoteDesktop

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
logparser  
fiddler4  
PhantomJS  
GoogleChrome  
firefox  
lastpass  
Office365ProPlus  
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
