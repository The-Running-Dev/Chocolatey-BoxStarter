param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $version = '12.0.30501.20150616'

    if ($force) {
        $global:au_Version = $version
    }

    return @{
        Url32 = 'http://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x86.exe';
        Version = $version
    }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')