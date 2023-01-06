$zipFile = "https://drive.google.com/u/0/uc?id=1rltcJQoLFDvGxlY5xclnVDHTtQU4ZoLW&export=download"
Invoke-WebRequest -Uri $zipFile -OutFile 'C:\Temp\website.pfx'
$Path='C:\Temp\website.pfx'
$Secure_String_Pwd = ConvertTo-SecureString "123" -AsPlainText -Force
Import-PfxCertificate -FilePath $Path -Password $Secure_String_Pwd -CertStoreLocation "Cert:\LocalMachine\My"
$iisCert = Get-ChildItem -Path "Cert:\LocalMachine\MY" | where{$_.Subject -eq "CN=beta.360imprimir.pt"}
$applicationId = [Guid]::NewGuid().ToString("B") 
netsh http add sslcert ipport=0.0.0.0:443 certhash=$($iisCert.Thumbprint) appid=$applicationId
New-WebBinding -Name "360imprimir-beta-BR" -IP "*" -Port 443 -Protocol https  
