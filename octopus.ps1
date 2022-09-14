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
$array = $ROLE.split(",")
./Tentacle.exe register-with --instance "Tentacle" --server $SERVER --apiKey $APIKEY --publicHostName=$ipv4 --space $SPACE --role $array[0] --role $array[1] --role $array[2] --role $array[3] --environment $ENVIRONMENT --comms-style TentaclePassive --force --console
#./Tentacle.exe register-with --instance "Tentacle" --server $SERVER --apiKey $APIKEY --publicHostName=$ipv4 --space $SPACE $ROLE --environment $ENVIRONMENT --comms-style TentaclePassive --force --console
