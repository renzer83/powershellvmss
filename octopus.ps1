param (
    $APIKEY,
    $NAME,
    $SERVER,
    $PORT,
    $SPACE,
    $ENVIRONMENT,
    $ROLE,
    $POLICY,
    $serverThumbprint
)

$ipv4 = Get-NetIPAddress -AddressFamily IPv4 -InterfaceIndex $(Get-NetConnectionProfile | Select-Object -ExpandProperty InterfaceIndex) | Select-Object -ExpandProperty IPAddress
cd "C:\Program Files\Octopus Deploy\Tentacle" 
.\Tentacle.exe deregister-from --server $SERVER --apiKey $APIKEY --instance=$NAME  --space=$SPACE
Start-Sleep -Seconds 2
New-Object -TypeName System.Collections.ArrayList
$arrlist = [System.Collections.Arraylist]@($ROLE)

if ($arrlist.Length -eq 4) {
    ./Tentacle.exe register-with --instance "Tentacle" --server $SERVER --apiKey $APIKEY --publicHostName=$ipv4 --space $SPACE --role $ROLE[0] --role $arrlist[1] --role $arrlist[2] --role $arrlist[3] --environment $ENVIRONMENT --comms-style TentaclePassive --force --console
}
elseif ($arrlist.Length -eq 3) {
    ./Tentacle.exe register-with --instance "Tentacle" --server $SERVER --apiKey $APIKEY --publicHostName=$ipv4 --space $SPACE --role $arrlist[0] --role $arrlist[1] --role $arrlist[2] --environment $ENVIRONMENT --comms-style TentaclePassive --force --console
}
elseif ($arrlist.Length -eq 2) {
    ./Tentacle.exe register-with --instance "Tentacle" --server $SERVER --apiKey $APIKEY --publicHostName=$ipv4 --space $SPACE --role $arrlist[0] --role $arrlist[1] --environment $ENVIRONMENT --comms-style TentaclePassive --force --console
}
elseif ($arrlist.Length -eq 1) {
    ./Tentacle.exe register-with --instance "Tentacle" --server $SERVER --apiKey $APIKEY --publicHostName=$ipv4 --space $SPACE --role $arrlist[0] --environment $ENVIRONMENT --comms-style TentaclePassive --force --console
} 

