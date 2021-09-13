if([IntPtr]::Size -eq 4)
{
    write-error "You're using a 32-bit (x86) powershell instance, which is going to break things later on. Ensure you're running the 64-bit version!"
    return
}

#visual studio stuff
choco install visualstudio2019professional visualstudio2019-workload-netweb visualstudio2019-workload-azure netfx-4.7.2-devpack urlrewrite sql-server-express azure-data-studio -y

#vscode stuff
choco install vscode vscode-csharp vscode-icons vscode-powershell -y

# manual VS config stuff
    # must-have extensions:
        # VSVim - choco install vsvim -y
        # relative number
        # editor guidelines (Paul Harrington's one)
        # sonarlint
        # VSColorOutput
        # Productivity Power Tools (especially: shrink empty lines, align assignments)
        # Hide Main Menu, Title Bar, and Tabs
    # optional extensions:
        # auto theme switcher for win10 dark mode
        # AceJump
    # maybe?
        # CodeMaid - import codemaid settings from CodeMaid.config

# vscode stuff, have to loop bc it can only install one at a time
("formulahendry.code-runner", "ms-python.python", "ms-vscode.PowerShell",
"vscodevim.vim", "tranhl.find-then-jump") | % {
    code --install-extension $_
}

Copy-Item "~\stuff\vscode\settings.json" -Destination "$env:APPDATA\Code\User\settings.json" -Force


