If ($args[0] -eq "-h")
{
	Write-Host "Usage:`n"
	Write-Host "DbUp.Postgresql.ps1 [Database:sample] [Server:127.0.0.1]"
	[Environment]::Exit(1)
}

$db = $args[0]
If (-Not $db)
{
	$db = "sample"
}

$server = $args[1]
If (-Not $server)
{
	$server = "127.0.0.1"
}

$scriptRoot = Split-Path -parent $MyInvocation.MyCommand.Definition
Add-Type -Path (Join-Path -Path $scriptRoot '.\lib\DbUp.dll')
Add-Type -Path (Join-Path -Path $scriptRoot '.\lib\DbUp.Postgresql.dll')
$scriptRoot = Join-Path -Path $scriptRoot -ChildPath "..\src\Repository\Pgsql"

function Database($dbUp)
{
	return [PostgresqlExtensions]::PostgresqlDatabase($dbUp, "database=$db;server=$server;user id=postgres;password=postgres;")
}

. ".\DbUp.Common.ps1"

UpgradeOnce "Patches"
UpgradeEverytime "Programmability"