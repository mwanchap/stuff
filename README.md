1. Run powershell as admin
2. `Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))`
3. `choco install git -y`
4. `cd C:\`
5. `git clone https://github.com/mwanchap/configs.git`
6. go through each step in `install everything script.ps1`
