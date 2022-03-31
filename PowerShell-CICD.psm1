$Files = Get-ChildItem -Path $($PSScriptRoot + "\Public")#import all public files
$Files | ForEach-Object {
    . $_.FullName 
}