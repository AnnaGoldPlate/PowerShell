$Servicename = 'Eventlog'
$ServiceInfo = Get-Service -Name $Servicename
    
if ($ServiceInfo.Status -ne 'Running') {
    WriteHost 'Service is not started, started service'
   
    Start-Service -Name $ServiceName 
    $ServiceInfo.Refresh()
    Write-Host $ServiceInfo.Status
 } else {

    Write-Host 'The service is already running.'
    }


## Define the service name in variable
## Read the service from Windows to return a service object
## If the server is not running (ne)
## Write to the console that the service is not running
## Start the service
## Update the $ServiceInfo object to reflect the new state 
## Write to the console the status property which indicates the state of the service
## If the status is anything but running 
## Write to the console the service is already running
