﻿. (Join-Path $env:ChocolateyPackageFolder 'tools\Helpers.ps1')

$updatedOn = '2017.06.09 10:46:53'
$installerBase = 'Microsoft Office 365 Business'
$parameters = Get-Parameters $env:chocolateyPackageParameters
$defaultConfigurationFile = Join-Path $env:ChocolateyPackageFolder 'Configuration.xml'
$configurationFile = Get-ConfigurationFile $parameters.ConfigurationFile $defaultConfigurationFile

# The file is defined explictely so the update script can find it and embed it
$arguments = @{
    file           = 'Microsoft Office 365 Business.7z'
    destination    = $env:Temp
    executable     = "$installerBase\Setup.exe"
    silentArgs     = "/configure ""$configurationFile"""
    validExitCodes = @(2147781575, 2147205120)
}

Set-Features $parameters $configurationFile

Install-FromZip $arguments

Get-ChildItem $env:Temp -Filter $installerBase | Remove-Item -Recurse -Force
