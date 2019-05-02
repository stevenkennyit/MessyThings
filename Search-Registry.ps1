#Command: regsearch,<searchBase>, <key/value>
function Search-Registry($arg1, $arg2){
$searchBase = $arg1
    $keyValue = $arg2
    #cls; Write-Host "Searching" $searchBase "for" $keyValue "(Slow)" -ForegroundColor Yellow
    $res = gci $searchBase -Recurse -ErrorAction SilentlyContinue | ? {$_.property -eq $keyValue} 
    if($res){
        write-host "Found key" $keyValue "here:" $res.Name -ForegroundColor Green
    }
    else{
        Write-Host "Key" $keyValue "not found!" -ForegroundColor Red
    }
}
