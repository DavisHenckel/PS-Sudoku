<#
.SYNOPSIS
    Gets a user's number placement.
.DESCRIPTION
    Gets a user's number placement ensuring numbers are between 1 and 9 (inclusive)
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
        $Row, $Column, $NumToPlace = $null, $null, $null
        try {
            [int32]$Row = Read-Host -Prompt "Enter row placement(1-9)"
            [int32]$Column = Read-Host -Prompt "Enter column placement(1-9)"
            [int32]$NumToPlace = Read-Host -Prompt "Enter the nunber to place (1-9)" 
        }
        catch {
            Write-Error "Row, Column and Number must be a numeric value."
            continue
        }
        if (($Row -lt 10 -and $Row -gt 0) -and ($Column -lt 10 -and $Column -gt 0) -and ($NumToPlace -lt 10 -and $NumToPlace -gt 0) ) {
            $Placement = [System.Tuple]::Create($Row, $Column)
            return @($NumToPlace, $Placement)
        }
        Write-Error "Row, Column, and Number must be between 1-9 (inclusive)"
    }  
}