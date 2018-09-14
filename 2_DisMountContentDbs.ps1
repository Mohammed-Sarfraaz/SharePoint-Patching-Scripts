
    $rootCmd = $MyInvocation.MyCommand.Definition
    $root = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
    
    Write-Host "===== ContentDB===== $(Get-Date)" -Fore "Yellow"

        # Remove content
        $dbs = Get-SPContentDatabase
        if ($dbs) {
            $dbs | % {$wa = $_.WebApplication.Url; $_ | select Name, NormalizedDataSource, @{n = "WebApp"; e = {$wa}}} | Export-Csv "$root\contentdbs-$when.csv" -NoTypeInformation
            $dbs | % {
                "$($_.Name),$($_.NormalizedDataSource)"
                Dismount-SPContentDatabase $_ -Confirm:$false
            }
        }
 