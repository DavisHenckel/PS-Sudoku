Function IsGameFinished {
    param (
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuGrid
    )
    if (FindEmptySpot -SudokuGrid $SudokuGrid) {
        return $false
    }
    return $true
}