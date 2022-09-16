param (
    $USERNAME,
    $PASS,
    $POOLNAME,
)
Import-Module WebAdministration
$identity = @{  `
    identitytype="SpecificUser"; `
    username="$USERNAME"; `
    password="$PASS" `
}
Set-ItemProperty -Path "IIS:\AppPools\$POOLNAME" -name "processModel" -value $identity
 
