1. Run 64-bit powershell as admin
2. `Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))`
3. `choco install git -y`
4. `cd ~`
5. `git clone https://github.com/mwanchap/stuff.git`
6. `cd stuff`
6. `git config user.email matt@wanchap.com` (unless this is a test or throwaway installation)
7. `./install-scripts/0-Start.ps1`
