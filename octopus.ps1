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
$array = $ROLE.split(",")
if ($ENVIRONMENT -eq "05.PRD NA"){
    ./Tentacle.exe register-with --instance "Tentacle" --server $SERVER --apiKey $APIKEY --name "$NAME-MX" --publicHostName=$ipv4 --space $SPACE --role $array[0] --role $array[1] --role $array[2] --role $array[3] --environment $ENVIRONMENT --comms-style TentaclePassive --force --console
}
elseif ($ENVIRONMENT -eq "06.PRD BR"){
    ./Tentacle.exe register-with --instance "Tentacle" --server $SERVER --apiKey $APIKEY --name "$NAME-BR" --publicHostName=$ipv4 --space $SPACE --role $array[0] --role $array[1] --role $array[2] --role $array[3] --environment $ENVIRONMENT --comms-style TentaclePassive --force --console
}
elseif ($ENVIRONMENT -eq "07.PRD EU"){
    ./Tentacle.exe register-with --instance "Tentacle" --server $SERVER --apiKey $APIKEY --name "$NAME-EU"  --publicHostName=$ipv4 --space $SPACE --role $array[0] --role $array[1] --role $array[2] --role $array[3] --environment $ENVIRONMENT --comms-style TentaclePassive --force --console
}
else{
    ./Tentacle.exe register-with --instance "Tentacle" --server $SERVER --apiKey $APIKEY --name "$NAME-MX" --publicHostName=$ipv4 --space $SPACE --role $array[0] --role "MX" --environment $ENVIRONMENT --comms-style TentaclePassive --force --console
    ./Tentacle.exe register-with --instance "Tentacle" --server $SERVER --apiKey $APIKEY --name "$NAME-BR" --publicHostName=$ipv4 --space $SPACE --role $array[1] --role "BR" --environment $ENVIRONMENT --comms-style TentaclePassive --force --console
    ./Tentacle.exe register-with --instance "Tentacle" --server $SERVER --apiKey $APIKEY --name "$NAME-EU" --publicHostName=$ipv4 --space $SPACE --role $array[2] --role "PT" --role $array[3] --environment $ENVIRONMENT --comms-style TentaclePassive --force --console
}
