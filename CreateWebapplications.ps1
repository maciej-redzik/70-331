Add-PSSnapin Microsoft.SharePoint.PowerShell

#create appPool
$strPass = Read-Host -AsSecureString "Enter password for WebApp account"
$appPoolAccountCredentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "LAB\SP2013_WebApp",$strPass
$appPoolAccount = New-SPManagedAccount -Credential $appPoolAccountCredentials

#create webapplication
$authProvider = New-SPAuthenticationProvider -UseWindowsIntegratedAuthentication
$webApp = New-SPWebApplication -Name "Intranet" -ApplicationPool "IntranetAppPool" -ApplicationPoolAccount $appPoolAccount `
          -HostHeader "intranet.lab.local" -Url "http://intranet.lab.local" -Port 80 -AuthenticationProvider $authProvider `
          -DatabaseName "SP2013_IntranetContentDB"

#create content database
$contentDB = New-SPContentDatabase -Name "SP2013_AdminContentDB" -WebApplication "http://lab-sp01:20130/"

#move admin SPSites from non-compliant database to compliant database
$sites = Get-SPSite -WebApplication "http://lab-sp01:20130/"
$sites | Move-SPSite -DestinationDatabase $contentDB

Remove-SPContentDatabase -Identity 681fa0b0-22ee-4e30-90c1-3698b6c34473

#Create basic SPSite in intranet webapp
New-SPSite -Name "Intranet" -Url "http://intranet.lab.local" -Language 1033 -OwnerAlias "LAB\SP2013_Setup" -Template "STS#0" -ContentDatabase "SP2013_IntranetContentDB" -CompatibilityLevel 15