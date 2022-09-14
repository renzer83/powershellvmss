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
if ($ROLE.count -eq 4) {
    ./Tentacle.exe register-with --instance "Tentacle" --server $SERVER --apiKey $APIKEY --publicHostName=$ipv4 --space $SPACE --role $ROLE[0] --role $ROLE[1] --role $ROLE[2] --role $ROLE[3] --environment $ENVIRONMENT --comms-style TentaclePassive --force --console
}
#./Tentacle.exe register-with --instance "Tentacle" --server $SERVER --apiKey $APIKEY --publicHostName=$ipv4 --space $SPACE $ROLE --environment $ENVIRONMENT --comms-style TentaclePassive --force --console

