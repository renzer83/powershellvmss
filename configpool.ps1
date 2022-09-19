param (
    $USERNAME,
    $PASS,
    $POOLNAME,
)
Import-Module WebAdministration
$identity = @{  `
    identitytype="SpecificUser"; `
    username="$USERNAME"; `
    password="$PASS" `
}

$array = $POOLNAME.split(",")
if ($array.count -eq 4){
    Set-ItemProperty -Path "IIS:\AppPools\$array[0]" -name "processModel" -value $identity
    Set-ItemProperty -Path "IIS:\AppPools\$array[1]" -name "processModel" -value $identity
    Set-ItemProperty -Path "IIS:\AppPools\$array[2]" -name "processModel" -value $identity
    Start-WebAppPool -Name $array[0]
    Start-WebAppPool -Name $array[1]
    Start-WebAppPool -Name $array[2]
}
elseif ($array.count -eq 2){
    Set-ItemProperty -Path "IIS:\AppPools\$array[0]" -name "processModel" -value $identity
    ./Tentacle.exe register-with --instance "Tentacle" --server $SERVER --apiKey $APIKEY --publicHostName=$ipv4 --space $SPACE --role $array[0] --role $array[1] --environment $ENVIRONMENT --comms-style TentaclePassive --force --console
}
 
Start-WebAppPool -Name 360imprimir-beta-BR
Start-WebAppPool -Name 360imprimir-beta-MX
Start-WebAppPool -Name 360imprimir-beta-PT
