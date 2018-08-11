#Requires -RunAsAdministrator
$ErrorActionPreference = "Inquire"

function Write-Heading
{
    $NL = [System.Environment]::NewLine
    Write-Host -ForegroundColor Blue "$NL    $args $NL"
}

Write-Heading "Running tasks..."
#execute a bunch of things
$tasks = @(
    [pscustomobject]@{name="ahk shortcuts"; exec = "C:\configs\Matt's Shortcuts.ahk"},
    [pscustomobject]@{name="easywindowdrag"; exec = "C:\configs\EasyWindowDrag_(KDE).ahk"},
    [pscustomobject]@{name="negativescreen"; exec = "negativescreen"},
    [pscustomobject]@{name="conemu"; exec = "ConEmu64"},
    [pscustomobject]@{name="sharex"; exec = "C:\Program Files\ShareX\ShareX.exe"}
);

foreach ($task in $tasks)
{
    write-host "Starting $($task.name)";
    . $task.exec
}

#clear scratch dir
Write-Heading "Clearing scratch dir..."
Remove-Item C:\scratch\* -Recurse -Force

#remove outlook reply sig
#TODO: this might not work on future installs.  perhaps find the correct subkey where Account Name == "Matt.Wanchap@cpal.com.au"?
Write-Heading "Removing outlook reply sig..."
$settingsLocation = "HKCU:\Software\Microsoft\Office\16.0\Outlook\Profiles\matt.wanchap\9375CFF0413111d3B88A00104B2A6676\00000002\"

if(Test-Path $settingsLocation)
{
    Set-ItemProperty -Path $settingsLocation -Name "Reply-Forward Signature" -Value "(none)"
}

#check for outdated packages
Write-Heading "Checking for outdated packages"
. choco outdated

