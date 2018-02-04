Add-PSSnapin Microsoft.SharePoint.PowerShell

#0. Get application pool
$appPool = Get-SPServiceApplicationPool | Where-Object {$_.Name -eq "ServiceAppPool"}

#1. Create user profile service application
$profileApp = New-SPProfileServiceApplication -Name "User Profile Service Application" -ApplicationPool $appPool -ProfileDBName "SP2013_UP_ProfileDB" -SocialDBName "SP2013_UP_SocialDB" `
 -ProfileSyncDBName "SP2013_UP_SyncDB" -MySiteHostLocation "http://my.lab.local" -MySiteManagedPath "/personal"

#2. Create user profile service app proxy
$proxy = New-SPProfileServiceApplicationProxy -Name "User Profile Service Application Proxy" -ServiceApplication $profileApp

#3. Check if SP_Farm Admin account is in "Administrators" local group
$members = net localgroup administrators | 
where {$_ -AND $_ -notmatch "command completed successfully"} | 
select -skip 4

if($members -contains "SP2013_Farm"){
    Write-Host "SP_Farm account is already a member of local Administrators group!" -ForegroundColor Green
}
else{
    Write-Host "SP_Farm account is not a member of local Administrators group!" -ForegroundColor Red
}

#4. Start User-Profile service and User-Profile service synchronisation (SPService)
$userProfileService = Get-SPServiceInstance | Where-Object { $_.TypeName -eq "User Profile Service" }
$userProfileSyncService = Get-SPServiceInstance | Where-Object { $_.TypeName -eq "User Profile Synchronization Service" }

Start-SPServiceInstance $userProfileService
Start-SPServiceInstance $userProfileSyncService

#5. Run full synchronization of AD. Plan synchronization schedule.
