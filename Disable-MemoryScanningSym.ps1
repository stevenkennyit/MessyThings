#DisableMemoryScanningSym
#Command: regsearch,<searchBase>, <key/value>
function Disable-MemoryScanningSym(){
    $searchBase = "HKLM:\SOFTWARE\WOW6432Node\Symantec\Symantec Endpoint Protection\AV\Storages\Filesystem\RealTimeScan" 
    $keyValue = "DeferredScanning"
    cls; Write-Host "Adding" $keyValue "with value of 0 to" $searchBase -ForegroundColor Yellow
    try{
        Set-ItemProperty -Path $searchBase -Name $keyValue -Value 0 -ErrorAction Stop
        Write-Host "Success!"
    }
    catch{
        $Error[0]
    }   
}
