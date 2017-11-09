param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $downloadUrl = 'https://download.docker.com/win/stable/InstallDocker.msi'
    $version = Get-MatchingTextFromUrl 'https://docs.docker.com/docker-for-windows/release-notes/' 'Community Edition ([0-9\.\-]+)-ce'

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')