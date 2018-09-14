Add-PSSnapin Microsoft.SharePoint.PowerShell

$ssa =Get-SPEnterpriseSearchServiceApplication –Identity "Search Service Application"

$ssa | Resume-SPEnterpriseSearchServiceApplication
