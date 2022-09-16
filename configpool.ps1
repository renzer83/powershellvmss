param


Import-Module WebAdministration
$identity = @{  `
    identitytype="SpecificUser"; `
    username=""; `
    password="" `
}
Set-ItemProperty -Path "IIS:\AppPools\$WebsiteName" -name "processModel" -value $identity
 
