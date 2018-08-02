$ErrorActionPreference = "Inquire"

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
    write-host "starting $($task.name)";
    . $task.exec
}

#clear scratch dir
Remove-Item C:\scratch\* -Recurse -Force

#TODO: remove outlook reply sig

