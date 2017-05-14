function Restore-SqlServerBackup {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)][string] $server,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true)][string] $database,
        [Parameter(Position = 3, ValueFromPipelineByPropertyName = $true)][string] $backup
    )

    $sqlServer = New-Object Microsoft.SqlServer.Management.Smo.Server $server

    $dbRestore = New-Object Microsoft.SqlServer.Management.Smo.Restore
    $dbRestore.Database = $database

    $dbRestoreFile = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile
    $dbRestoreFile.LogicalFileName = $database
    $dbRestoreFile.PhysicalFileName = "$($sqlServer.Information.MasterDBPath)\$($dbRestore.Database)_Data.mdf"

    $dbRestoreLog = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile
    $dbRestoreLog.LogicalFileName = "$database_Log"
    $dbRestoreLog.PhysicalFileName = "$($sqlServer.Information.MasterDBLogPath)\$($dbRestore.Database)_Log.ldf"

    $dbRestore.Devices.AddDevice($backup, 'File')
    $dbRestore.ReplaceDatabase = $true
    $dbRestore.RelocateFiles.Add($dbRestoreFile)
    $dbRestore.RelocateFiles.Add($dbRestoreLog)

    $sqlServer.KillAllProcesses($database)
    $dbRestore.SqlRestore($sqlServer)

    Write-Host "Database $database restored successfully..."
}