Add-PSSnapin Microsoft.SharePoint.PowerShell


$appPool = Get-SPServiceApplicationPool "ServicesAppPool"

$subscriptionService = New-SPSubscriptionSettingsServiceApplication -ApplicationPool $appPool -Name "Microsoft SharePoint Foundation Subscription Settings Service" -DatabaseName "SP2019_SubscriptionSettingsDB"
$subscriptionServiceProxy = New-SPSubscriptionSettingsServiceApplicationProxy -ServiceApplication $subscriptionService

$appManagementService = New-SPAppManagementServiceApplication -Name "App Management Service" -DatabaseName "SP2019_AppManagementDB" -ApplicationPool $appPool
$appManagementServiceProxy = New-SPAppManagementServiceApplicationProxy -ServiceApplication $appManagementService -Name "App Management Service Proxy"


Get-SPAppDomain