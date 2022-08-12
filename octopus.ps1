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

## Download client Octopus and install
$clientURL = "https://octopus.com/downloads/latest/WindowsX64/OctopusTentacle"
$clientDestination = "C:\Temp\Octopus.Tentacle.latest.msi"
$serverThumbprint = $serverThumbprint
Invoke-WebRequest $clientURL -OutFile $clientDestination
cd C:\Temp
msiexec INSTALLLOCATION="C:\OctopusDeploy\Tentacle" /i Octopus.Tentacle.latest.msi /quiet
$ipv4 = Get-NetIPAddress -AddressFamily IPv4 -InterfaceIndex $(Get-NetConnectionProfile | Select-Object -ExpandProperty InterfaceIndex) | Select-Object -ExpandProperty IPAddress
Start-Sleep -Seconds 5
cd "C:\OctopusDeploy\Tentacle"
# Configure Tentacle Octopus
./Tentacle.exe create-instance --instance "Tentacle" --config "C:\Octopus\Tentacle.config" --console
./Tentacle.exe new-certificate --instance "Tentacle" --if-blank --console
./Tentacle.exe configure --instance "Tentacle" --reset-trust --console
./Tentacle.exe configure --instance "Tentacle" --home "C:\Octopus" --app "C:\Octopus\Applications" --port $PORT --console
./Tentacle.exe configure --instance "Tentacle" --trust $serverThumbprint --console
netsh advfirewall firewall add rule "name=Octopus Deploy Tentacle" dir=in action=allow protocol=TCP localport=$PORT
./Tentacle.exe register-with --instance "Tentacle" --server $SERVER --apiKey $APIKEY --publicHostName=$ipv4 --space $SPACE --role $ROLE --environment $ENVIRONMENT --comms-style TentaclePassive --console
./Tentacle.exe service --instance "Tentacle" --install --start --console
