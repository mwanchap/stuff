#create directories if they don't already exist
("C:\code", "C:\scratch") | foreach-object {
    if (-not (Test-Path $_))
    {
        new-item $_ -type dir
    }
}

#install most useful stuff
choco install googlechrome vim git autohotkey.install ditto alt-tab-terminator keypirinha -y

# setup redirected config for vim
"source ~\\stuff\\.vimrc" | out-file ~\.vimrc -NoNewline -Encoding utf8;

# redirected config for git
$escHome = $env:HOME.Replace('\',"\\");
"[include]
    path = $escHome\\stuff\\.gitconfig
[core]
    excludesfile = $escHome\\stuff\\.gitignore_global" | out-file ~\.gitconfig -NoNewline -Encoding utf8;

# redirected powershell profile
". ~\stuff\Microsoft.PowerShell_profile.ps1" | out-file $profile -NoNewline -Encoding utf8;

#alt-tab terminator hotkey
$attRegPath = "HKCU:\Software\Alexander Avdonin\Alt-Tab Terminator\3.0\"
if (Test-Path $attRegPath)
{
    Set-ItemProperty -Path $attRegPath -Name "HkCustom1" -Value 192
}
