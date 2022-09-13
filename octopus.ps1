param (
    $APIKEY,
    $NAME,
    $SERVER,
    $PORT,
    $SPACE,
    $ENVIRONMENT,
    [String[]]$ROLE,
    $POLICY,
    $serverThumbprint
)

$ipv4 = Get-NetIPAddress -AddressFamily IPv4 -InterfaceIndex $(Get-NetConnectionProfile | Select-Object -ExpandProperty InterfaceIndex) | Select-Object -ExpandProperty IPAddress
cd "C:\Program Files\Octopus Deploy\Tentacle" 
.\Tentacle.exe deregister-from --server $SERVER --apiKey $APIKEY --instance=$NAME  --space=$SPACE
Start-Sleep -Seconds 2
New-Object -TypeName System.Collections.ArrayList
$arrlist = [System.Collections.Arraylist]@()
For ($i=0; $i -lt $ROLE.Length; $i++) {
    $arrlist.Add("--role="+$ROLE[$i])
    }
Write-Host $arrlist 
$result = $arrlist.Substring(1)
./Tentacle.exe register-with --instance "Tentacle" --server $SERVER --apiKey $APIKEY --publicHostName=$ipv4 --space $SPACE $result --environment $ENVIRONMENT --comms-style TentaclePassive --force --console 

