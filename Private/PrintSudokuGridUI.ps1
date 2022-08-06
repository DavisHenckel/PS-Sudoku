Function PrintSudokuGridUI {
    Param (
        [parameter(Mandatory=$true)]
        [System.Object]$OriginalGrid,
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuGrid
    )
    Write-Host "+++++++++++++++++++++++++"
    For($Row = 1; $Row -lt 10; $Row++) {
        If ($Row -eq 4 -or $Row -eq 7) {
            Write-Host "|-------+-------+------ |" 
        }
        For($Col = 1; $Col -lt 10; $Col++) {
            If ($Col -eq 1) {
                Write-Host "| " -NoNewline
            }
            $CurrentItem = $SudokuGrid[$Row-1][$Col-1]
            If ($OriginalGrid[$Row-1][$Col-1] -ne '-') {
                Write-Host -ForegroundColor Green -NoNewline "$CurrentItem "
            }
            ElseIf ($CurrentItem -ne '-') {
                Write-Host -ForegroundColor Yellow -NoNewline "$CurrentItem "
            }
            Else {
                Write-Host -NoNewline "$CurrentItem "
            }
            If ($Col % 3 -eq 0 -and $Col -ne 9) {
                Write-Host "| " -NoNewline
            }
            ElseIf($Col -eq 9) {
                Write-Host "|" 
            }
        }   
    }
    Write-Host "+++++++++++++++++++++++++" 
}
