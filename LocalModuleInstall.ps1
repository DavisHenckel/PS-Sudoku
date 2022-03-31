# Script to install the module locally. 
# This is used prior to publishing the module to the PowerShell Gallery
[CmdletBinding()]

$StringsJSONData = Get-Content -Path ("$($PSScriptRoot)" + ".\strings.json") | ConvertFrom-Json
$Version = $StringsJSONData."ModuleVersion"
Function DetermineCorrectModulePath {
    $PossiblePaths = $env:PSModulePath.Split(";")
    ForEach ($Path in $PossiblePaths) {
        if ($Path -match "Program Files") {
            return $Path
        }
    }
    return $PossiblePaths[0] #if only 1 path and not programfiles.
}

$InstallPath = DetermineCorrectModulePath
$InstallPath = $InstallPath + "\PowerShell-CICD"
if (Test-Path $InstallPath) {
    Write-Host "Uninstalling pre-existing module versions..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $InstallPath
}
Write-Host "Installing PowerShell-CICD module version $Version`..." -ForegroundColor Green
New-Item -ItemType Directory "$InstallPath\$Version" | Out-Null
Copy-Item "$($PSScriptRoot)\*" -Exclude "*git*" -Recurse -Destination "$InstallPath\$Version"
Write-Host "Ensuring module is properly installed..." -ForegroundColor Yellow
Import-Module PowerShell-CICD
if (-not (Get-Command -Module PowerShell-CICD)){
    Write-Host "Module not installed properly. Manually move the folder to $InstallPath \ $Version" -ForegroundColor Red
}
else {
    Write-Host "PowerShell-CICD version $Version installed successfully!" -ForegroundColor Green
}
Pause
