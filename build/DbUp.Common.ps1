function PerformUpgrade([string]$context, [bool] $useJournal = $true)
{
	$scriptsPath = Join-Path -Path $scriptRoot -ChildPath $context
	$dbUp = [DbUp.DeployChanges]::To
	$dbUp = Database $dbUp
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