param([switch] $force)

. (Join-Path $PSScriptRoot '..\Build\update.begin.ps1')

$releasesUrl = 'https://www.xyplorer.com/download.php'
$versionRegEx = '([0-9\.]+), released'
$downloadUrl = 'https://www.xyplorer.com/download/xyplorer_full_noinstall.zip'

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $html = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl
    $versionInfo = [regex]::match($html.Content, $versionRegEx)
    $version = [version]$versionInfo.Groups[1].Value

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Build\update.end.ps1')