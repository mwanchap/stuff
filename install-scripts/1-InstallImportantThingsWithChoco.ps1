#create directories if they don't already exist
("C:\code", "C:\scratch") | foreach-object {
    if (-not (Test-Path $_))
    {
        new-item $_ -type dir
    }
}

#install most useful stuff
choco install googlechrome vim git autohotkey.install ditto alt-tab-terminator keypirinha -y

#setup redirected configs for vim, git and PS
"source C:\configs\.vimrc" | out-file ~\.vimrc -NoNewline -Encoding utf8;
"[include]`n    path = C:\\configs\\.gitconfig" | out-file ~\.gitconfig -NoNewline -Encoding utf8;
". C:\configs\Microsoft.PowerShell_profile.ps1" | out-file $profile -NoNewline -Encoding utf8;

#alt-tab terminator hotkey
$attRegPath = "HKCU:\Software\Alexander Avdonin\Alt-Tab Terminator\3.0\"
if (Test-Path $attRegPath)
{
    Set-ItemProperty -Path $attRegPath -Name "HkCustom1" -Value 192
}
