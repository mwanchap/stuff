Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-9bda399\src\posh-git.psd1'

#Import-Module VSTeam
#Add-VSTeamAccount -Profile vsts -Drive vsteam
#New-PSDrive -Name vsteam -PSProvider SHiPS -Root 'VSTeam#VSTeamAccount'

#$host.UI.RawUI.ForegroundColor = "DarkGray"
#$host.UI.RawUI.BackgroundColor = "White"
#$host.PrivateData.VerboseForegroundColor = "DarkYellow"
#$host.PrivateData.DebugForegroundColor = "DarkYellow"
#$host.PrivateData.ProgressForegroundColor = "DarkYellow"
#$host.PrivateData.WarningForegroundColor = "DarkYellow"
#$host.PrivateData.ErrorForegroundColor = "Red"
#$host.PrivateData.VerboseBackgroundColor = "White"
#$host.PrivateData.DebugBackgroundColor = "White"
#$host.PrivateData.ProgressBackgroundColor = "White"
#$host.PrivateData.WarningBackgroundColor = "White"
#$host.PrivateData.ErrorBackgroundColor = "White"
#Set-PSReadlineOption -ResetTokenColors
Set-Alias vim 'C:\Program Files (x86)\Vim\vim80\gvim.exe'
Set-Alias csi 'C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\Roslyn\csi.exe'
Set-Alias sf 'force'
Set-Alias sfdx 'C:\Program Files\Salesforce CLI\bin\sfdx.cmd'
Set-Alias stree "C:\Program Files (x86)\Atlassian\Sourcetree\SourceTree.exe"
#write-host "To log in to Azure:"
#write-host "Import-Module AzureRM" -ForegroundColor "Yellow"
#write-host "Login-AzureRMAccount" -ForegroundColor "Yellow"
#write ""
#write-host "To connect to a server:"
#write-host "Import-Module WebAdministration" -ForegroundColor "Yellow"
#write-host "Get-Credential" -ForegroundColor "Yellow"
#write-host "Enter-PSSession" -ForegroundColor "Yellow"
#write-host "Or to connect to a server, " -ForegroundColor "Yellow"
$scriptdir = "$env:OneDrive\Scripts\Powershell"
$homedir = "\\svwhaefl02\homedrives$\Matt.Wanchap\Documents"
Clear-Host
write-host "Scripts are in " -nonewline
write-host "`$scriptdir" -ForegroundColor "Green"  -nonewline
write-host ", other stuff goes in " -nonewline
write-host "`$homedir" -ForegroundColor "Green"
Set-Location "C:\"
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

function prompt
{
  #$p = Split-Path -leaf -path (Get-Location) #just gets last part of path
  $origLastExitCode = $LASTEXITCODE
  Write-Host $ExecutionContext.SessionState.Path.CurrentLocation -NoNewline
  Write-VcsStatus
  $LASTEXITCODE = $origLastExitCode
  "`n$('>' * ($nestedPromptLevel + 1))"
}

function search
{
    param
    (
        [string]$filePattern="*.*",
        [string]$searchStr
    )

    get-childitem $filePattern -Recurse | sls $searchStr
}

function Obliterate
{
    remove-item $args -force -recurse -confirm
}

function SFFields
{
    (force describe -n="$($args[0])" -t=sobject | ConvertFrom-Json).Fields | Sort-Object name | Select-Object -ExpandProperty name
}

function SFUser
{
    <#
    .SYNOPSIS
        Opens the Salesforce user profile page for the first user returned by a query for a partial username match
    .EXAMPLE
        SFUser matt.wanchap
    .PARAMETER
        The only parameter is the username, which does not need to be complete.  The query uses LIKE so only part of the name needs to be provided.
    #>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [string]$username
    )

    $users = (force query --format csv "select id from user where username like '%$username%' and isactive=true" | convertfrom-csv)
    
    if($users.Count -eq 0)
    {
        Write-Host "No users found";
        return;
    }
    else
    {
        foreach($user in $users)
        {
            Start-Process -filepath "https://cpal.my.salesforce.com/$($user.Id)?noredirect=1&isUserEntityOverride=1" 
        }
    }
}

function SFUserID
{
    (force query "SELECT Id FROM User WHERE Name LIKE '%$($args[0])%' LIMIT 1" --format:csv | ConvertFrom-Csv).Id
}

function SFQuery
{
    force query "SELECT Id FROM $($args[0])" --format:csv | ConvertFrom-Csv
}

function SFUpdate
{
    Param($Type, $Where, $Update)
    #eg: SFUpdate -Type Contact -Where "OwnerId='$(sfuserid Kirsty)'" -Update "OwnerId:$(sfuserid Isabelle)"
    force query "select Id FROM $Type WHERE $Where" --format:csv | ConvertFrom-Csv | % {force record update $Type $_.Id $Update }
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
