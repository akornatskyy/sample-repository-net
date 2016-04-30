If ($args[0] -eq "-h")
{
	Write-Host "Usage:`n"
	Write-Host "DbUp.ps1 [Database:Sample] [Server:(LOCAL)]"
	[Environment]::Exit(1)
}

$db = $args[0]
If (-Not $db)
{
	$db = "Sample"
}

$server = $args[1]
If (-Not $server)
{
	$server = "(LOCAL)"
}

$scriptRoot = Split-Path -parent $MyInvocation.MyCommand.Definition
Add-Type -Path (Join-Path -Path $scriptRoot '.\lib\DbUp.dll')
$scriptRoot = Join-Path -Path $scriptRoot -ChildPath "..\src\Repository\Sql"

function Database($dbUp)
{
	return [SqlServerExtensions]::SqlDatabase($dbUp, "database=$db;server=$server;Trusted_Connection=Yes")
}

. ".\DbUp.Common.ps1"

UpgradeOnce "Patches"
UpgradeEverytime "Programmability"