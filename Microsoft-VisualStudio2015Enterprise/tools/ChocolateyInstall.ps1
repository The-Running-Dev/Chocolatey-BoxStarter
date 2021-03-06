﻿. (Join-Path $env:ChocolateyPackageFolder 'tools\Helpers.ps1')

$updatedOn = '2018.12.12 03:44:40'
$defaultConfigurationFile = Join-Path $env:ChocolateyPackageFolder 'Configuration.xml'
$parameters = Get-Parameters $env:chocolateyPackageParameters
$configurationFile = Get-ConfigurationFile $parameters['Configuration'] $defaultConfigurationFile
$arguments = @{
    url            = 'https://download.my.visualstudio.com/pr/en_visual_studio_enterprise_2015_with_update_3_x86_x64_web_installer_8922986.exe'
    checksum       = 'D970DFE1230A8E46B2543C60EA468663AE1511C2043A0B9714F99BF1A1BF35FB'
    silentArgs     = "/Quiet /NoRestart /NoRefresh /Log $env:Temp\VisualStudio.log /AdminFile $configuration"
    validExitCodes = @(2147781575, 2147205120)
}

Set-Features $parameters $configurationFile

Install-Package $arguments
