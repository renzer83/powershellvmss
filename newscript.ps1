Param(
    [string]$dotnetInstallDir = 'C:\dotnet',
    [string]$dotnetVersion = 'Latest',
    [string]$dotnetChannel = 'Current'
)

If(-NOT (Test-Path $env:SystemDrive\'azagent')){mkdir $env:SystemDrive\'azagent'}; cd $env:SystemDrive\'azagent'
