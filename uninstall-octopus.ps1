param (
    $SERVER
)

cd "C:\OctopusDeploy\Tentacle"
.\Tentacle.exe deregister-worker --server="$SERVER"
Start-Sleep -Seconds 5
cd C:\Temp
msiexec.exe /x "Octopus.Tentacle.latest.msi" /QN
cd
Start-Sleep -Seconds 5
Remove-Item -LiteralPath "C:\Octopus" -Force -Recurse
Remove-Item -LiteralPath "C:\OctopusDeploy" -Force -Recurse  
sc.exe delete "OctopusDeploy Tentacle"
