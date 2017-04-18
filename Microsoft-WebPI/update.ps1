param([switch] $force, [switch] $push)

$originalLocation = Get-Location
$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\_Scripts\update.begin.ps1')

function global:au_GetLatest {
    $version = '5.0'

    if ($force) {
        $global:au_Version = $version
    }

    return @{
        Url32 = 'http://download.microsoft.com/download/F/4/2/F42AB12D-C935-4E65-9D98-4E56F9ACBC8E/wpilauncher.exe';
        Version = $version
    }
}

. (Join-Path $PSScriptRoot '..\_Scripts\update.end.ps1')