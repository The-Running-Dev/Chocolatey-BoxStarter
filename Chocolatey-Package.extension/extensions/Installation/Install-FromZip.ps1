function Install-FromZip {
    param(
        [PSCustomObject] $arguments
    )

    $packageArgs = Get-Arguments $arguments

    $originalFile = $packageArgs.file

    if (Test-FileExists $packageArgs.file) {
        Write-Message "Install-FromZip: Unzipping to $($arguments.destination)"

        Get-ChocolateyUnzip @packageArgs
    }
    elseif ($packageArgs.url) {
        Write-Message "Install-FromZip: Installing zip with Install-ChocolateyZipPackage"
        Install-ChocolateyZipPackage @packageArgs
    }

    if ($packageArgs.executableRegEx) {
        Write-Message "Install-FromZip: No executable specified, using regex '$($packageArgs.executableRegEx)'"
        $arguments.file = Get-Executable $packageArgs.destination $packageArgs.executableRegEx

        # Re-map the file type
        $packageArgs.fileType = Get-FileExtension $packageArgs.file
    }
    elseif ($packageArgs.executable) {
        Write-Message "Install-FromZip: Finding executable '$($packageArgs.executable)' in $packageArgs.destination"
        # Re-map the file to the unzip executable
        $packageArgs.file = Join-Path $packageArgs.destination $packageArgs.executable

        # Re-map the file type
        $packageArgs.fileType = Get-FileExtension $packageArgs.file
    }

    # The original zip was extracted and the file was re-maped
    if ($originalFile -ne $packageArgs.file) {
        Write-Message "Install-FromZip: Installing with $($packageArgs.file)"
        Install-ChocolateyInstallPackage @packageArgs
    }
}