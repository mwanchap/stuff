#create directories if they don't already exist
("C:\code", "C:\scratch") | foreach-object
{
    if (-not (Test-Path $_))
    {
        new-item $_ -type dir
    }
}

#important dev stuff
choco install googlechrome vim git autohotkey.install ditto alt-tab-terminator keypirinha -y

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
    $trigger = New-ScheduledTaskTrigger -AtLogOn -User $env:USERNAME
    $principal = New-ScheduledTaskPrincipal -UserId $env:USERNAME -RunLevel Highest
    $settings = New-ScheduledTaskSettingsSet
    $settings.DisallowStartIfOnBatteries = $false
    $settings.StopIfGoingOnBatteries = $false
    $newTask = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings -Description TaskDescription
    Register-ScheduledTask -TaskName $TaskName -InputObject $newTask
}

ScheduleStartupTask -TaskName "startup tasks" -TaskDescription "Runs startup tasks script" -ExecPath "powershell" -ExecArgs "-NoProfile -Command "". 'C:\configs\startup tasks.ps1'""";

#setup redirected configs for vim, git and PS, then install vim plugins
"source C:\configs\.vimrc" | out-file ~\.vimrc -NoNewline -Encoding utf8;
"[include]`n    path = C:\\configs\\.gitconfig" | out-file ~\.gitconfig -NoNewline -Encoding utf8;
". C:\configs\Microsoft.PowerShell_profile.ps1" | out-file $profile -NoNewline -Encoding utf8;
new-item ~\vimfiles\bundle -type dir | set-location;
git clone https://github.com/VundleVim/Vundle.vim.git;
vim +PluginInstall +qall;

#visual studio stuff
choco install visualstudio2017professional visualstudio2017-workload-netweb visualstudio2017-workload-azure netfx-4.7.2-devpack vsvim urlrewrite -y

#IIS stuff
("IIS-WebServerRole","IIS-WebServer","IIS-CommonHttpFeatures","IIS-HttpErrors","IIS-HttpRedirect",
"IIS-ApplicationDevelopment","IIS-NetFxExtensibility","IIS-NetFxExtensibility45","IIS-HealthAndDiagnostics",
"IIS-HttpLogging","IIS-LoggingLibraries","IIS-RequestMonitor","IIS-HttpTracing","IIS-Security",
"IIS-URLAuthorization","IIS-RequestFiltering","IIS-IPSecurity","IIS-Performance","IIS-HttpCompressionDynamic",
"IIS-WebServerManagementTools","IIS-ManagementScriptingTools","IIS-IIS6ManagementCompatibility","IIS-Metabase",
"IIS-StaticContent","IIS-DefaultDocument","IIS-DirectoryBrowsing","IIS-WebSockets","IIS-ApplicationInit",
"IIS-ASPNET","IIS-ASPNET45","IIS-ASP","IIS-CGI","IIS-ISAPIExtensions","IIS-ISAPIFilter",
"IIS-ServerSideIncludes","IIS-CustomLogging","IIS-BasicAuthentication","IIS-HttpCompressionStatic",
"IIS-ManagementConsole","IIS-ManagementService","IIS-WMICompatibility","IIS-LegacyScripts",
"IIS-LegacySnapIn","IIS-CertProvider","IIS-WindowsAuthentication","IIS-DigestAuthentication",
"IIS-ClientCertificateMappingAuthentication","IIS-IISCertificateMappingAuthentication",
"IIS-ODBCLogging") | % { write-host $_; Enable-WindowsOptionalFeature -Online -FeatureName $_; }

#other software
choco install googlechrome.canary nodejs.install sysinternals 7zip.install firefox vlc conemu paint.net windirstat azure-cli poshgit sumatrapdf.install irfanview negativescreen sourcetree kdiff3 sql-server-management-studio microsoftazurestorageexplorer TortoiseGit rdcman qmmp postman sharex winscp force-cli rescuetime ilspy grepwin -y

#sharex hotkey
if (Test-Path "$homedir\ShareX")
{
    Copy-Item "C:\configs\ShareX\*.*" -Destination "$homedir\ShareX\"
}

#alt-tab terminator hotkey
$attRegPath = "HKCU:\Software\Alexander Avdonin\Alt-Tab Terminator\3.0\"
if (Test-Path $attRegPath)
{
    Set-ItemProperty -Path $attRegPath -Name "HkCustom1" -Value 192
}

# vscode stuff, have to loop bc it can only install one at a time
("formulahendry.code-runner", "ms-python.python", "ms-vscode.PowerShell",
"vscodevim.vim") | % {
    code --install-extension $_
}

Copy-Item "C:\configs\vscode\settings.json" -Destination "$env:APPDATA\Code\User\settings.json -Force"

#powershell stuff
Install-PackageProvider -Name NuGet -Force
Install-Module "AzureRM","AzureAD","ImportExcel", "VSTeam" -Force
Update-Help

#python stuff
choco install python3 -y
python -m pip install --upgrade pip
python -m pip install matplotlib scipy numpy openpyxl pandas jupyter
