# PowerShell
Function Get-Compinfo{
[cmdletbinding()]
param(
[Parameter(Mandatory=$true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)]
[String[]]$DnsHost 
)
PROCESS{
    FOREACH($Computer in $DnsHost){
   

$os = Get-CimInstance -ClassName win32_operatingsystem -computername $Computer -ErrorAction SilentlyContinue

#$now= (Get-Date)

$boot = $os.LastBootUpTime
$Uptime = $os.LocalDateTime - $os.Lastbootuptime

$cdrive = get-wmiobject win32_logicaldisk -filter "DeviceID = 'C:'" -ComputerName $Computer -ErrorAction SilentlyContinue
        

 $Properties = [ordered]@{
 Computername = $Computer;
'OS' = $os.Caption;
'LastBootUp' = $boot;
'UpTimeHours' = $Uptime;
'C:_GB_Free' = ($Cdrive.Freespace/1GB -as [int])

}

$obj = New-Object -TypeName PSObject -Property $Properties
$obj.PSObject.TypeNames.Insert(0,"MyInventory")

$FormatEnumerationLimit = -1
Write-Output $obj
$obj | Select-Object -Property computer,os,LastBootUp,UpTimeHours,c:_GB_Free | Export-Csv -Path C:\TEST.CSV -NoTypeInformation -Append
}

}
}

