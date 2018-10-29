"Step 1 at $((Get-Date).ToLongTimeString())" >> progress.txt
. C:\configs\install-scripts\1-InstallImportantThingsWithChoco.ps1

"Step 2 at $((Get-Date).ToLongTimeString())" >> progress.txt
. C:\configs\install-scripts\2-ScheduleTasks.ps1

Start-Sleep -Seconds 5

"Restarting at $((Get-Date).ToLongTimeString())" >> progress.txt
Restart-Computer
