function PrintSudokuGridUI {
    param (
        [parameter(Mandatory=$true)]
        [System.Object]$OriginalGrid,
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuGrid
    )
    Write-Host "+++++++++++++++++++++++++"
    For($Row = 1; $Row -lt 10; $Row++) {
        if ($Row % 4 -eq 0) {
            Write-Host "|-------+-------+------ |" 
        }
        For($Col = 1; $Col -lt 10; $Col++) {
            if ($Col -eq 1) {
                Write-Host "| " -NoNewline
            }
            $CurrentItem = $SudokuGrid[$Row-1][$Col-1]
            if ($OriginalGrid[$Row-1][$Col-1] -ne '-') {
                Write-Host -ForegroundColor Green -NoNewline "$CurrentItem "
            }
            elseif ($CurrentItem -ne '-') {
                Write-Host -ForegroundColor Yellow -NoNewline "$CurrentItem "
            }
            else {
                Write-Host -NoNewline "$CurrentItem "
            }
            if ($Col % 3 -eq 0 -and $Col -ne 9) {
                Write-Host "| " -NoNewline
            }
            elseif($Col -eq 9) {
                Write-Host "|" 
            }
        }   
    }
    Write-Host "+++++++++++++++++++++++++" 
}
