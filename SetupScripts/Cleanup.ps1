Import-Module WebAdministration

$currentPath = Split-Path $script:MyInvocation.MyCommand.Path
$variables = Join-Path $currentPath "\Variables.ps1"
. $variables
. $iisModule
. $sqlModule
. $functionsModule

function ProjectCleanup()
{
    write-output "Project Cleanup"
    
    DeleteAllSitesWithSameBinding $defaultWebsitePort

    Remove-WebAppPool $appPollName -ErrorAction continue

    EnsureDBDeleted $databaseServer $databaseName
    
    CleanWebsiteDirectory $projectBuildLocation, 10, $appPollName
}