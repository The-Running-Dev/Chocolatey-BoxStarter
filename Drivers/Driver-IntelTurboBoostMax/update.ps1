param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot
$settingsDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\..\Scripts\update.onchange.begin.ps1')

. (Join-Path $PSScriptRoot '..\..\Scripts\update.end.ps1')