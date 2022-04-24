Function DetermineCorrectModulePath {
    $PossiblePaths = $env:PSModulePath.Split(";")
    return $PossiblePaths[0]
}
# Script to install the module locally. 
# This is used prior to publishing the module to the PowerShell Gallery
Try {
    $StringsJSONData = Get-Content -Path ("$($PSScriptRoot)" + ".\strings.json") | ConvertFrom-Json
}
Catch {
    $StringsJSONData = Get-Content -Path ("$($PSScriptRoot)" + "/strings.json") | ConvertFrom-Json
}
$Version = $StringsJSONData."ModuleVersion"

$InstallPath = $null
if ($IsWindows) {
    $InstallPath = "C:\Users\runneradmin\Documents\PowerShell\Modules\PowerShell-CICD"
}
if ($IsLinux) {
    $InstallPath = "/home/runner/.local/share/powershell/Modules/PowerShell-CICD"
}
elseif ($IsMacOS) {
    $InstallPath = "/Users/runner/.local/share/powershell/Modules/PowerShell-CICD"
}
else {
    $InstallPath = DetermineCorrectModulePath
    $InstallPath = $InstallPath + "\PowerShell-CICD"
}
if (Test-Path $InstallPath) {
    Write-Host "Uninstalling pre-existing module versions..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $InstallPath
}
Write-Host "Installing PowerShell-CICD module version $Version`..." -ForegroundColor Green
New-Item -ItemType Directory "$InstallPath\$Version" | Out-Null
Copy-Item "$($PSScriptRoot)\*" -Exclude "*git*" -Recurse -Destination "$InstallPath\$Version"
Write-Host "Ensuring module is properly installed..." -ForegroundColor Yellow
Import-Module PowerShell-CICD -Force
if (-not (Get-Command -Module PowerShell-CICD)){
    Write-Host "Module not installed properly. Manually move the folder to $InstallPath`\`$Version" -ForegroundColor Red
}
else {
    Write-Host "PowerShell-CICD version $Version installed successfully!" -ForegroundColor Green
}
Pause
