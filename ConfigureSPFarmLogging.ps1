Add-PSSnapin Microsoft.SharePoint.PowerShell

Get-SPLogLevel                                              #Shows all log levels
Get-SPLogLevel -Identity "SharePoint Foundation:*"          #Shows all log levels for specific category
Get-SPLogLevel -Identity "SharePoint Foundation:Web Parts"  #Shows log level for specific category and item

#Set log level for specific item...
Set-SPLogLevel -Identity "SharePoint Foundation:Web Parts" `
               -TraceSeverity Verbose -EventSeverity Verbose

#...and clear
Clear-SPLogLevel

#Write Trace Log (Uls Log) to powershell window
Get-SPLogEvent -StartTime "12.27.2017 12:01:00" -EndTime "12.27.2017 12:01:01"
#Filtering is done by 

#Do the same - but write to file:
Merge-SPLogFile -StartTime "12.27.2017 12:01:00" -EndTime "12.27.2017 12:01:01" -Path "trace_log.log"
#Additional parameters: Correlation, Category, Message, Level, etc.
