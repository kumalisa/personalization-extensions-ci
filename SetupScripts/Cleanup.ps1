Import-Module WebAdministration
$variables = Join-Path $currentPath "\Variables.ps1"
. $variables
. $iisModule
. $sqlModule
. $functionsModule

function ProjectCleanup()
{
    DeleteAllSitesWithSameBinding $defaultWebsitePort

    Remove-WebAppPool $appPollName -ErrorAction continue

    EnsureDBDeleted $databaseServer $databaseName
    
    CleanWebsiteDirectory $projectBuildLocation, 10, $appPollName
}