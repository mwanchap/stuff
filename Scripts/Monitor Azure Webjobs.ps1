Write-Host 'Checking webjobs'

$webApps = az webapp list | convertfrom-json

$webApps | Foreach-Object -ThrottleLimit 30 -Parallel {
    az webapp webjob continuous list --name $_.name --resource-group $_.resourceGroup | convertfrom-json | where name -notlike '*ApplicationInsightsProfiler*' | select status,name
}

Write-Host "Done"
Read-Host "Press return to finish"
