#other software
choco install googlechrome.canary nodejs.install sysinternals 7zip.install firefox vlc conemu windirstat azure-cli poshgit sumatrapdf.install irfanview negativescreen sourcetree kdiff3 microsoftazurestorageexplorer TortoiseGit rdcman qmmp postman sharex winscp force-cli rescuetime ilspy grepwin paint.net -y

#sharex hotkey
if (Test-Path "$homedir\ShareX")
{
    Copy-Item "C:\configs\ShareX\*.*" -Destination "$homedir\ShareX\"
}

#powershell stuff
Install-PackageProvider -Name NuGet -Force
Install-Module "AzureRM","AzureAD","ImportExcel", "VSTeam" -Force
Update-Help

#python stuff
choco install python3 -y
python -m pip install --upgrade pip
python -m pip install matplotlib scipy numpy openpyxl pandas jupyter

