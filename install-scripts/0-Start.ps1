"Step 1 at $((Get-Date).ToLongTimeString())" >> progress.txt
.\1-InstallImportantThingsWithChoco.ps1

"Step 2 at $((Get-Date).ToLongTimeString())" >> progress.txt
.\2-ScheduleTasks.ps1

Restart-Computer
