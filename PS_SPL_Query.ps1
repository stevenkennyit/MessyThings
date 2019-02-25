######## DO NOT REMOVE! This will allow for self-signed SSL certs to work and other stuff ########
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
[System.Net.ServicePointManager]::MaxServicePointIdleTime = 5000000
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
##################################################################################

#Parameters 
$cred = Get-Credential adminUserID
$userID = "Target Username" 

#Export location
$outLocation = "c:\temp\" + $userID + "_SPL_Query.csv"

$server = 'yourServerNameOrIP'
$url = "https://${server}:8089/services/search/jobs/export" # braces needed b/c the colon is otherwise a scope operator
$search = 'search index="wineventlog" Account_Name=' + '"' + $userID + '"' # Cmdlet handles urlencoding
$body = @{
    search = $search 
    output_mode = "json"
    earliest_time = "-30m"
}
$result = Invoke-RestMethod -Method Post -Uri $url -Credential $cred -Body $body 
#Working well!


#Messy way to parse out what we want 
Remove-Item $outLocation -Force -ErrorAction SilentlyContinue
$elements = $result -split "}}"
$array = New-Object System.Collections.ArrayList
foreach($e in $elements){
    Write-Host "##########" -ForegroundColor Green
    $test = ($e + "}}" | ConvertFrom-Json -ErrorAction SilentlyContinue).result
    $test | select @{Name="Security_ID";Expression={$_.Security_ID -join "; "}}, @{Name="Account_Domain ";Expression={$_.Account_Domain  -join "; "}}, @{Name="EventCode ";Expression={(($test._pre_msg -split "\n") | ? {$_ -like "EventCode=*"})}}, Workstation_Name, Source_Network_Address, ComputerName, _time, index | Export-Csv $outLocation -NoTypeInformation -Append
}
