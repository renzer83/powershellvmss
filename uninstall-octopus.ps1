param (
    $SERVER,
    $APIKEY,
    $SPACE
)

cd "C:\OctopusDeploy\Tentacle"
.\Tentacle.exe deregister-from --server $SERVER --apiKey $APIKEY --space $SPACE  
Start-Sleep -Seconds 5
cd C:\Temp
sc.exe stop "OctopusDeploy Tentacle"
msiexec.exe /x "Octopus.Tentacle.latest.msi" /QN
cd
Start-Sleep -Seconds 5
Remove-Item -LiteralPath "C:\Octopus" -Force -Recurse
Remove-Item -LiteralPath "C:\OctopusDeploy" -Force -Recurse  
sc.exe delete "OctopusDeploy Tentacle"
