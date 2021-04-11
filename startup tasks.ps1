#Requires -RunAsAdministrator
$ErrorActionPreference = "Inquire"

function Write-Heading
{
    $NL = [System.Environment]::NewLine
    Write-Host -ForegroundColor Blue "$NL $args $NL"
}

Write-Heading "Running tasks..."
$tasks = @(
    [pscustomobject]@{name="ahk shortcuts"; exec = "~\stuff\Matt's Shortcuts.ahk"},
    [pscustomobject]@{name="easywindowdrag"; exec = "~\stuff\EasyWindowDrag_(KDE).ahk"}
);

foreach ($task in $tasks)
{
    write-host "    Starting $($task.name)";
    . $task.exec
}

#clear scratch dir
Write-Heading "Clearing scratch dir..."
Remove-Item ~\scratch\* -Recurse -Force

Write-Heading "Copying spotlight images as wallpapers..."
& "~\stuff\Scripts\Windows Spotlight Wallpapers.ps1"

#check for outdated packages
Write-Heading "Checking for outdated packages..."
. choco upgrade all -y

Write-Heading "Done"
Read-Host "Press return to finish"
