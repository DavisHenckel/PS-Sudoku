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
    $InstallPath = "C:\Users\runneradmin\Documents\PowerShell\Modules\PS-Sudoku"
}
if ($IsLinux) {
    $InstallPath = "/home/runner/.local/share/powershell/Modules/PS-Sudoku"
}
elseif ($IsMacOS) {
    $InstallPath = "/Users/runner/.local/share/powershell/Modules/PS-Sudoku"
}
else {
    $InstallPath = DetermineCorrectModulePath
    $InstallPath = $InstallPath + "\PS-Sudoku"
}
if (Test-Path $InstallPath) {
    Write-Host "Uninstalling pre-existing module versions..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $InstallPath
}
Write-Host "Installing PS-Sudoku module version $Version`..." -ForegroundColor Green
New-Item -ItemType Directory "$InstallPath\$Version" | Out-Null
Copy-Item "$($PSScriptRoot)\*" -Exclude "*git*" -Recurse -Destination "$InstallPath\$Version"
Write-Host "Ensuring module is properly installed..." -ForegroundColor Yellow
Import-Module PS-Sudoku -Force
if (-not (Get-Command -Module PS-Sudoku)){
    Write-Host "Module not installed properly. Manually move the folder to $InstallPath`\`$Version" -ForegroundColor Red
}
else {
    Write-Host "PS-Sudoku version $Version installed successfully!" -ForegroundColor Green
}
Pause
