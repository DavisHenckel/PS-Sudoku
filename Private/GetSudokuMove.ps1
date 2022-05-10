<#
.SYNOPSIS
    Gets a user's number placement.
.DESCRIPTION
    Gets a user's number placement after validating the move is valid given the current state of the board.
.PARAMETER SudokuGrid   
    The current state of the Sudoku Grid.
.EXAMPLE
    $SudokuPlay = GetSudokuMove -SudokuGrid $Grid
.INPUTS
    Takes in a Sudoku Board
.OUTPUTS
    Returns a 2d Tuple, with [0] being the number to place and [1] being the row, column to place at.
#>
Function GetSudokuMove {
    param(
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuGrid
    )
    while($true) {
        #TODO Refactor into one function.
        # $Row = Read-Host -Prompt "Enter row placement(1-9)"
        # $Column = Read-Host -Prompt "Enter column placement(1-9)"
        # $NumToPlace = Read-Host -Prompt "Enter the nunber to place (1-9)"
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
            $Placement = [System.Tuple]::Create($Row, $Column)
            return @($NumToPlace, $Placement)
        }
    }  
}

# $t = GenerateGrid -Difficulty UniqueSolution
# PrintGrid -SudokuGrid $t
# $x = GetSudokuMove -SudokuGrid $t
# $b = 5