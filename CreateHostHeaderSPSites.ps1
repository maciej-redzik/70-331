Add-PSSnapin Microsoft.SharePoint.PowerShell

#1. SPWebApllication needs to be deployed using regular way
$webApp = Get-SPWebApplication "http://intranet.lab.local"

#2. Create few SPSites using HostHeader technique (can be done only by PowerShell!)
New-SPSite -Url "http://sales.lab.local/" -HostHeaderWebApplication $webApp -Name "Sales" -Language 1033 -Template "STS#0" -OwnerAlias "LAB\SP2013_Setup"
New-SPSite -Url "http://support.lab.local/" -HostHeaderWebApplication $webApp -Name "Support" -Language 1033 -Template "STS#0" -OwnerAlias "LAB\SP2013_Setup"
New-SPSite -Url "http://it.lab.local" -HostHeaderWebApplication $webApp -Name "IT" -Language 1033 -Template "STS#0" -OwnerAlias "LAB\SP2013_Setup"
New-SPSite -Url "http://my.lab.local" -HostHeaderWebApplication $webApp -Name "My Site Host" -Language 1033 -Template "SPSMSITEHOST#0" -OwnerAlias "LAB\SP2013_Setup"

#3. Add DNS 'A' entries in DNS
#Done manually by snap-in in Domain Controller

#4. Add bindings to IIS

New-WebBinding -Name "SharePoint - Header Host Web Application" -IPAddress "*" -Port 80 -HostHeader "sales.lab.local"
New-WebBinding -Name "SharePoint - Header Host Web Application" -IPAddress "*" -Port 80 -HostHeader "support.lab.local"
New-WebBinding -Name "SharePoint - Header Host Web Application" -IPAddress "*" -Port 80 -HostHeader "it.lab.local"
New-WebBinding -Name "SharePoint - Header Host Web Application" -IPAddress "*" -Port 80 -HostHeader "my.lab.local"