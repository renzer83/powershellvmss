param (
    $SERVER
)

cd "C:\OctopusDeploy\Tentacle"
.\Tentacle.exe deregister-worker --server=$SERVER
cd C:\Temp
msiexec.exe /x "Octopus.Tentacle.latest.msi" /QN
cd
Remove-Item -LiteralPath "C:\Octopus" -Force -Recurse
Remove-Item -LiteralPath "C:\OctopusDeploy" -Force -Recurse  
sc.exe delete "OctopusDeploy Tentacle"
