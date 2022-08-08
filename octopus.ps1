param (
    $APIKEY,
    $NAME,
    $SERVER,
    $PORT,
    $SPACE,
    $ENVIRONMENT,
    $ROLE,
    $POLICY
)

## Download client Octopus
$clientURL = "https://octopus.com/downloads/latest/WindowsX64/OctopusTentacle"
$clientDestination = "C:\Users\rootadmin\Downloads\Octopus.Tentacle.latest.msi"
Invoke-WebRequest $clientURL -OutFile $clientDestination
cd C:\Users\rootadmin\Downloads\
msiexec INSTALLLOCATION="C:\OctopusDeploy\Tentacle" /i Octopus.Tentacle.latest.msi /quiet

#msiexec.exe /x "Octopus.Tentacle.latest.msi"
cd C:\OctopusDeploy\Tentacle\
# Configure Tentacle Octopus
.\Tentacle.exe create-instance --instance "Tentacle" --config "C:\Octopus\Tentacle.config" --console
.\Tentacle.exe new-certificate --instance "Tentacle" --if-blank --console
.\Tentacle.exe configure --instance "Tentacle" --reset-trust --console
.\Tentacle.exe configure --instance "Tentacle" --app "C:\Octopus\Applications" --noListen "True" --console 
.\Tentacle.exe register-with --instance "Tentacle" --server $SERVER --name $NAME --comms-style "TentacleActive" --server-comms-port $PORT --apiKey $APIKEY --space $SPACE --force --environment $ENVIRONMENT --role $ROLE --policy $POLICY --console
.\Tentacle.exe service --instance "Tentacle" --install --stop --start --console
