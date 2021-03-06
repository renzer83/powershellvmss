Param(
    [string]$dotnetInstallDir = 'C:\dotnet',
    [string]$dotnetVersion = 'Latest',
    [string]$dotnetChannel = 'Current'
)
If(-NOT (Test-Path $env:SystemDrive\'azagent')){mkdir $env:SystemDrive\'azagent'}; cd $env:SystemDrive\'azagent'
for($i=1; $i -lt 100; $i++){$destFolder="A"+$i.ToString();if(-NOT (Test-Path ($destFolder))){mkdir $destFolder;cd $destFolder;break;}}; 
$agentZip="$PWD\agent.zip";$DefaultProxy=[System.Net.WebRequest]::DefaultWebProxy;$securityProtocol=@();$securityProtocol+=[Net.ServicePointManager]::SecurityProtocol;$securityProtocol+=[Net.SecurityProtocolType]::Tls12;[Net.ServicePointManager]::SecurityProtocol=$securityProtocol;$WebClient=New-Object Net.WebClient; $Uri='https://vstsagentpackage.azureedge.net/agent/2.191.1/vsts-agent-win-x64-2.191.1.zip';if($DefaultProxy -and (-not $DefaultProxy.IsBypassed($Uri))){$WebClient.Proxy= New-Object Net.WebProxy($DefaultProxy.GetProxy($Uri).OriginalString, $True);}; $WebClient.DownloadFile($Uri, $agentZip);Add-Type -AssemblyName System.IO.Compression.FileSystem;[System.IO.Compression.ZipFile]::ExtractToDirectory( $agentZip, "$PWD");.\config.cmd --deploymentgroup --deploymentgroupname "deploy-scaleset" --agent $env:COMPUTERNAME --runasservice --work '_work' --url 'https://renanwiter2.visualstudio.com/' --projectname 'Project labs' --auth PAT --token gf6jrxzleufsljeelr2bfug2chba2l5rbf6et46qbwxybxotsvwq --addDeploymentGroupTags --deploymentGroupTags "$env:COMPUTERNAME" --runAsService --windowsLogonAccount "NT AUTHORITY\SYSTEM" --replace --acceptTeeEula; Remove-Item $agentZip;
