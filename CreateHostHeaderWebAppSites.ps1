$appPoolName = "IntranetAppPool"
$appPoolAccount = Get-SPManagedAccount "DEV\SP_Content"


$hhwa = New-SPWebApplication -ApplicationPool $appPoolName -ApplicationPoolAccount $appPoolAccount -Name "Hosted Sites" -Port 443 -AuthenticationProvider (new-spauthenticationprovider -UseWindowsIntegratedAuthentication) -databaseName "SP2019_HostedSitesContentDB" -SecureSocketsLayer

$emptyRootSite = New-SPSite -Name "WebApp" -Url "https://webapp.dev.local" -Template STS#1 -Language 1033 -OwnerAlias "DEV\Administrator"
Write-Host -ForegroundColor Green "Created Root Site at URL: $($emptyRootSite.Url)"

$hostedSite1 = New-SPSite -Name "Hosted Site 1" -Url https://hosted1.dev.local -HostHeaderWebApplication $hhwa -Template STS#0 -Language 1033 -ContentDatabase "SP2019_HostedSitesContentDB" -OwnerAlias "DEV\Administrator"
Write-Host -ForegroundColor Green "Created DST Site at URL: $($hostedSite1.Url)"

$hostedSite2 = New-SPSite -Name "Hosted Site 2" -Url https://hosted2.dev.local -HostHeaderWebApplication $hhwa -Template STS#0 -Language 1033 -ContentDatabase "SP2019_HostedSitesContentDB" -OwnerAlias "DEV\Administrator"
Write-Host -ForegroundColor Green "Created Bluedocs Site at URL: $($hostedSite2.Url)"


#After sites are created, you need to:
# - add SSL wildcard certificate in site bindings
# - disable HTTP/2