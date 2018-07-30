#create directories
new-item C:\code -type dir
new-item C:\scratch -type dir

#important dev stuff
choco install googlechrome visualstudio2017professional visualstudio2017-workload-netweb visualstudio2017-workload-azure netfx-4.7.2-devpack vim git.install urlrewrite autohotkey.install ditto alt-tab-terminator -y

#setup redirected configs for vim, git and PS, then install vim plugins
"source C:\configs\.vimrc" | out-file ~\.vimrc -NoNewline -Encoding utf8
"[include]`n    path = C:\\configs\\.gitconfig" | out-file ~\.gitconfig -NoNewline -Encoding utf8
". C:\configs\Microsoft.PowerShell_profile.ps1" | out-file $profile -NoNewline -Encoding utf8
new-item ~\vimfiles\bundle -type dir | set-location
git clone https://github.com/VundleVim/Vundle.vim.git
vim +PluginInstall +qall

#schedule startup tasks
function ScheduleStartupTask
{
    param
    (
        [string]$TaskName,
        [string]$TaskDescription,
        [string]$ExecPath,
        $ExecArgs
    )

    $oldTask = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue

    if ($oldTask -ne $null)
    {
        Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false 
    }

    $actionParams = @{ Execute = $ExecPath }

    if ($ExecArgs)
    {
        $actionParams.Add("Argument", $ExecArgs)
    }

    $action = New-ScheduledTaskAction @actionParams
    $trigger = New-ScheduledTaskTrigger -AtLogOn
    $principal = New-ScheduledTaskPrincipal -UserId $env:USERNAME -RunLevel Highest
    $settings = New-ScheduledTaskSettingsSet
    $newTask = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings -Description TaskDescription
    Register-ScheduledTask -TaskName $TaskName -InputObject $newTask
}

ScheduleStartupTask -TaskName "startup - ahk shortcuts" -TaskDescription "Runs my AHK shortcuts at startup" -ExecPath "C:\configs\Matt's Shortcuts.ahk"
ScheduleStartupTask -TaskName "startup - easywindowdrag" -TaskDescription "Runs AHK easywindowdrag script at startup" -ExecPath "C:\configs\EasyWindowDrag_(KDE).ahk"

$psGenericArgs = "-WindowStyle Hidden -NoProfile"
ScheduleStartupTask -TaskName "startup - clear scratch dir" -TaskDescription "Erases everything in the scratch dir" -ExecPath "powershell" -ExecArgs "$psGenericArgs -Command ""Remove-Item C:\scratch\* -Recurse -Force"""
ScheduleStartupTask -TaskName "startup - remove outlook reply sig" -TaskDescription "Removes the reply signature from outlook" -ExecPath "powershell" -ExecArgs "$psGenericArgs -Command "" """

#IIS stuff
("IIS-WebServerRole","IIS-WebServer","IIS-CommonHttpFeatures","IIS-HttpErrors","IIS-HttpRedirect","IIS-ApplicationDevelopment","IIS-NetFxExtensibility","IIS-NetFxExtensibility45","IIS-HealthAndDiagnostics","IIS-HttpLogging","IIS-LoggingLibraries","IIS-RequestMonitor","IIS-HttpTracing","IIS-Security","IIS-URLAuthorization","IIS-RequestFiltering","IIS-IPSecurity","IIS-Performance","IIS-HttpCompressionDynamic","IIS-WebServerManagementTools","IIS-ManagementScriptingTools","IIS-IIS6ManagementCompatibility","IIS-Metabase","IIS-StaticContent","IIS-DefaultDocument","IIS-DirectoryBrowsing","IIS-WebSockets","IIS-ApplicationInit","IIS-ASPNET","IIS-ASPNET45","IIS-ASP","IIS-CGI","IIS-ISAPIExtensions","IIS-ISAPIFilter","IIS-ServerSideIncludes","IIS-CustomLogging","IIS-BasicAuthentication","IIS-HttpCompressionStatic","IIS-ManagementConsole","IIS-ManagementService","IIS-WMICompatibility","IIS-LegacyScripts","IIS-LegacySnapIn","IIS-CertProvider","IIS-WindowsAuthentication","IIS-DigestAuthentication","IIS-ClientCertificateMappingAuthentication","IIS-IISCertificateMappingAuthentication","IIS-ODBCLogging") | % { Enable-WindowsOptionalFeature -Online -FeatureName $_ }

#other software
choco install googlechrome.canary nodejs.install sysinternals 7zip.install firefox vlc conemu paint.net windirstat azure-cli poshgit sumatrapdf.install irfanview negativescreen sourcetree spotify kdiff3 sql-server-management-studio microsoftazurestorageexplorer TortoiseGit rdcman qmmp postman sharex winscp -y

#todo: install force.com cli

#python stuff
choco install python3 -y
python -m pip install --upgrade pip
python -m pip install matplotlib scipy numpy openpyxl pandas

#powershell stuff
Install-Module "AzureRM","ImportExcel", "VSTeam" -Force
Update-Help

#todo: setup shortcuts for startup
#todo: setup scheduled tasks:
#1: run ahk scripts as admin
#2: clear scratch dir at startup