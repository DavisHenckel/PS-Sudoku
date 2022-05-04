$PublicFiles = Get-ChildItem -Path $($PSScriptRoot + "\Public") # import all public files
$PublicFiles | ForEach-Object {
    . $_.FullName 
}
$PrivateFiles = Get-ChildItem -Path $($PSScriptRoot + "\Private" ) # import all private files these won't be exported from the psd1
$PrivateFiles | ForEach-Object {
    . $_.FullName 
}