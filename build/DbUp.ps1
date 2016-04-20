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

$connectionString = "database=$db;server=$server;Trusted_Connection=Yes"

$scriptRoot = Split-Path -parent $MyInvocation.MyCommand.Definition
Add-Type -Path (Join-Path -Path $scriptRoot '.\DbUp.dll')
$scriptRoot = Join-Path -Path $scriptRoot -ChildPath "..\src\Repository\Sql"


function PerformUpgrade([string]$context, [bool] $useJournal = $true)
{
	$scriptsPath = Join-Path -Path $scriptRoot -ChildPath $context
	$dbUp = [DbUp.DeployChanges]::To
	$dbUp = [SqlServerExtensions]::SqlDatabase($dbUp, $connectionString)
	If (-Not $useJournal)
	{
		$dbUp = [StandardExtensions]::JournalTo($dbUp, (New-Object -TypeName DbUp.Helpers.NullJournal))
	}

	$dbUp = [StandardExtensions]::WithTransaction($dbUp)
	$dbUp = [StandardExtensions]::WithScriptsFromFileSystem($dbUp, $scriptsPath)
	$dbUp = [StandardExtensions]::LogToConsole($dbUp)
	$r = $dbUp.Build().PerformUpgrade()
	If (-Not $r.Successful)
	{
		[Environment]::Exit(1)
	}	
}

function UpgradeOnce($context)
{
	Write-Host "[$context] Running one time scripts ..." -ForegroundColor Yellow
	PerformUpgrade $context
}

function UpgradeEverytime($context)
{
	Write-Host "`n[$context] Running every time scripts ..." -ForegroundColor Yellow
	PerformUpgrade $context -useJournal $false 
}


UpgradeOnce "Patches"
UpgradeEverytime "Programmability"