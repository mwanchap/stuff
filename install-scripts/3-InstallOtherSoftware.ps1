if([IntPtr]::Size -eq 4)
{
    write-error "You're using a 32-bit (x86) powershell instance, which is going to break things later on. Ensure you're running the 64-bit version!"
    return
}

#install vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git $env:userprofile\vimfiles\bundle\Vundle.vim;
vim +PluginInstall +qall;

#other software
choco install nodejs.install sysinternals 7zip.install firefox windirstat poshgit sumatrapdf.install negativescreen kdiff3 postman sharex ilspy grepwin paint.net csvfileview cascadiacode wsudo fiddler hxd switcheroo docker-desktop dotnetfx microsoft-windows-terminal bitwarden -y

#sharex hotkey
if (Test-Path "$homedir\ShareX")
{
    Copy-Item "~\stuff\ShareX\*.*" -Destination "$homedir\ShareX\"
}

#powershell stuff
Install-PackageProvider -Name NuGet -Force
#Install-Module "AzureRM","AzureAD","ImportExcel","sqlserver" -Force
Update-Help

#python stuff
choco install python3 -y
python -m pip install --upgrade pip
#python -m pip install matplotlib scipy numpy openpyxl pandas jupyter

