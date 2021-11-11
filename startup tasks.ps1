#Requires -RunAsAdministrator
$ErrorActionPreference = "Inquire"

function Write-Heading
{
    $NL = [System.Environment]::NewLine
    Write-Host -ForegroundColor Blue "$NL $args $NL"
}

Write-Heading "Running tasks..."
$tasks = @(
    [pscustomobject]@{name="ahk shortcuts"; exec = "~\stuff\Matt's Shortcuts.ahk"; args = ""},
    [pscustomobject]@{name="easywindowdrag"; exec = "~\stuff\EasyWindowDrag_(KDE).ahk"; args = ""}
    [pscustomobject]@{name="mouse jiggler"; exec = "C:\ProgramData\chocolatey\bin\MouseJiggler.exe"; args = "-j -m -z"}
);

foreach ($task in $tasks)
{
    write-host "    Starting $($task.name)";
    Start-Process -FilePath $task.exec -ArgumentList $task.args
}

#clear scratch dir
Write-Heading "Clearing scratch dir..."
Remove-Item ~\scratch\* -Recurse -Force

#check for outdated packages
Write-Heading "Checking for outdated packages..."
. choco upgrade all -y

Write-Heading "Done"
Read-Host "Press return to finish"
