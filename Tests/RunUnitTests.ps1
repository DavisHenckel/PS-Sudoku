Write-Host "Running All Unit Tests..." -ForegroundColor Cyan
Get-ChildItem | ForEach-Object {
    & $_.FullName
}