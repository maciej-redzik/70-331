#In Central Administration:
# Central Adm. -> Application Management -> Specify quota templates

Add-PSSnapin Microsoft.SharePoint.PowerShell

$limitedSiteQuota = New-Object Microsoft.SharePoint.Administration.SPQuotaTemplate
$limitedSiteQuota.Name = "Limited Site";
$limitedSiteQuota.StorageMaximumLevel = 104857600;  #In bytes (100MB = 1024 * 1024 * 100 bytes)
$limitedSiteQuota.StorageWarningLevel = $limitedSiteQuota.StorageMaximumLevel * 0.8;
$limitedSiteQuota.UserCodeMaximumLevel = 0; #For sandbox solutions
$limitedSiteQuota.UserCodeWarningLevel = 0; #For sandbox solutions
$spContentSrv = [Microsoft.SharePoint.Administration.SPWebService]::ContentService;
$spContentSrv.QuotaTemplates.Add($limitedSiteQuota);
$spContentSrv.Update();

#Delete site quota
$spContentSrv = [Microsoft.SharePoint.Administration.SPWebService]::ContentService;
$spContentSrv.QuotaTemplates.Delete("Limited Site");
$spContentSrv.Update();

#Apply site quota to SPSite

$site = Get-SPSite http://intranet.dev.local/sites/site1
$site | Set-SPSite -QuotaTemplate $limitedSiteQuota

#Tip: If you remove quota template without unapplying it from sites 
#     -> all sites will receive individual quouta with the same parameters as quota template deleted.