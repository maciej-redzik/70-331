Add-PSSnapin Microsoft.SharePoint.PowerShell

#1. Create usage service application
New-SPUsageApplication -Name "Usage and Health Data Collection Service Application" -DatabaseName "SP2013_UsageHealthDB"
