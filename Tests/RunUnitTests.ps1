Write-Host "Running All Unit Tests..." -ForegroundColor Cyan
Get-ChildItem -Path $PSScriptRoot\UnitTests\ | ForEach-Object {
    & $_.FullName
}