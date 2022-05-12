<#
.SYNOPSIS
    Validates a Sudoku move.
.DESCRIPTION
    Validates a number placement given the current state of the board
.PARAMETER SudokuGrid   
    The current state of the Sudoku Grid.
.EXAMPLE
    $SudokuPlay = ValidateSudokuMove -SudokuGrid $Grid
.INPUTS
    Takes in a Sudoku Board
.OUTPUTS
    Returns a boolean indicating if the move is valid.
#>
Function ValidateSudokuMove {
    param(
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuGrid,
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuMove
    )
    $Row, $Column, $NumToPlace = $SudokuMove[1].Item1, $SudokuMove[1].Item2, $SudokuMove[0]
    $RowValid = IsRowPlacementValid -SudokuGrid $SudokuGrid -Row $Row -Number $NumToPlace
    $ColValid = IsColumnPlacementValid -SudokuGrid $SudokuGrid -Column $Column -Number $NumToPlace
    $SubgridValid = IsSubgridPlacementValid -SudokuGrid $SudokuGrid -Row $Row -Column $Column -Number $NumToPlace
    Write-Host "Row Placement: " -ForegroundColor Yellow -NoNewline
    if ($RowValid) {
        Write-Host "Valid!" -ForegroundColor Green
    }
    else {
        Write-Host "Invalid!" -ForegroundColor Red
    }
    Write-Host "Column Placement: " -ForegroundColor Yellow  -NoNewline
    if ($ColValid) {
        Write-Host "Valid!" -ForegroundColor Green
    }
    else {
        Write-Host "Invalid!" -ForegroundColor Red
    }
    Write-Host "Subgrid Placement: " -ForegroundColor Yellow  -NoNewline
    if ($SubgridValid) {
        Write-Host "Valid!" -ForegroundColor Green
    }
    else {
        Write-Host "Invalid!" -ForegroundColor Red
    }
    if ($RowValid -and $ColValid -and $SubgridValid) {
        return $true
    }
    return $false
}