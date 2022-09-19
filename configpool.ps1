 param (
    $USERNAME,
    $PASS,
    $POOLNAME
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
