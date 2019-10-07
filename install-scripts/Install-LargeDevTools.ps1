#visual studio stuff
choco install visualstudio2017professional visualstudio2017-workload-netweb visualstudio2017-workload-azure netfx-4.7.2-devpack urlrewrite sql-server-express azure-data-studio -y

#vscode stuff
choco install vscode vscode-csharp vscode-icons vscode-powershell -y

#manual VS config stuff
    #choco install vsvim -y
    #install these extensions
        #relative number
        #editor guidelines (Paul Harrington's one)
        #sonarlint
    #import codemaid settings from CodeMaid.config

# vscode stuff, have to loop bc it can only install one at a time
("formulahendry.code-runner", "ms-python.python", "ms-vscode.PowerShell",
"vscodevim.vim", "tranhl.find-then-jump") | % {
    code --install-extension $_
}

Copy-Item "~\stuff\vscode\settings.json" -Destination "$env:APPDATA\Code\User\settings.json" -Force


