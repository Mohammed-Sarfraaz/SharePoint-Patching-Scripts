
     $rootCmd = $MyInvocation.MyCommand.Definition
     $root = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
 
 
        # Add content
		$files = Get-ChildItem "$root\contentdbs-*.csv" | Sort LastAccessTime -Desc
		if ($files -is [Array]) {
			$files = $files[0]
		}
		
        # Loop databases
        $dbs = Import-Csv $files.Fullname
        $counter = 0
        $dbs | % {
            $name = $_.Name
            $name
			
            # Progress
            $prct = [Math]::Round(($counter / $dbs.Count) * 100)
            Write-Progress -Activity "Add database" -Status "$name ($prct %) $(Get-Date)" -PercentComplete $prct
            $counter++
        
            $wa = Get-SPWebApplication $_.WebApp
            Mount-SPContentDatabase -WebApplication $wa -Name $name -DatabaseServer $_.NormalizedDataSource | Out-Null
        }
