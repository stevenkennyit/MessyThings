#Disable-MemoryScanningSym
function Disable-MemoryScanningSym(){
    $searchBase = "HKLM:\SOFTWARE\WOW6432Node\Symantec\Symantec Endpoint Protection\AV\Storages\Filesystem\RealTimeScan" 
    $keyValue = "XXXXXXXXDeferredScanning"
    cls; Write-Host "Adding" $keyValue "with value of 0 to" $searchBase -ForegroundColor Yellow
    try{
        Set-ItemProperty -Path $searchBase -Name $keyValue -Value 0
        Write-Host "Success!"
    }
    catch{
        $Error[0]
    }   
}
