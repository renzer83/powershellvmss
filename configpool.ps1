 param (
    $USERNAME,
    $PASS,
    $POOLNAME,
    $URL,
    $CERT,
    $NA
)
Import-Module WebAdministration
$identity = @{  `
    identitytype="SpecificUser"; `
    username="$USERNAME"; `
    password="$PASS" `
}

$array = $POOLNAME.split(",")
$pool = ""

for ($i=0; $i -lt $array.length; $i++){   

   Try{
       $pool =  $array[$i].ToString()
       Set-ItemProperty -Path "IIS:\AppPools\$pool" -name "processModel" -value $identity
       Write-Host ("Update and start sucess " +$pool ) -ForegroundColor Green
       }
   Catch{
     Write-Host ("Failed to update " +$pool ) -ForegroundColor Red
   } 

   Start-WebAppPool -Name $pool

} 

$zipFile = $URL
Invoke-WebRequest -Uri $zipFile -OutFile 'C:\Temp\website.pfx'
$Path='C:\Temp\website.pfx'
$Secure_String_Pwd = ConvertTo-SecureString $CERT -AsPlainText -Force
Import-PfxCertificate -FilePath $Path -Password $Secure_String_Pwd -CertStoreLocation "Cert:\LocalMachine\My"
$iisCert = Get-ChildItem -Path "Cert:\LocalMachine\MY" | where{$_.Subject -eq "CN=beta.360imprimir.pt"}
$applicationId = [Guid]::NewGuid().ToString("B") 
netsh http add sslcert ipport=0.0.0.0:443 certhash=$($iisCert.Thumbprint) appid=$applicationId
New-WebBinding -Name $NA -IP "*" -Port 443 -Protocol https  

