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
    Param(
        [parameter(Mandatory=$true)]
        [System.Object]$SudokuGrid,
        [parameter(Mandatory=$true)]
        [System.Object]$OriginalGrid
    )
    $Counter = 0
    While($true) {
        $Counter++
        If  ($Counter %3 -eq 0) {
            PrintSudokuGridUI -SudokuGrid $SudokuGrid -OriginalGrid $OriginalGrid
        }
        $Row, $Column, $NumToPlace = $null, $null, $null
        $Row = Read-Host -Prompt "Enter row placement(1-9)"
        If ($Row -eq '-hint' -or $Row -eq '-solve') {
            Return $Row
        }
        $Column = Read-Host -Prompt "Enter column placement(1-9)"
        If ($Column -eq '-hint' -or $Column -eq '-solve') {
            Return $Column
        }
        $NumToPlace = Read-Host -Prompt "Enter the number to place (1-9)" 
        If ($NumToPlace -eq '-hint' -or $NumToPlace -eq '-solve') {
            Return $NumToPlace
        }
        Try {
            $Row, $Column, $NumToPlace = [int32]$Row, [int32]$Column, [int32]$NumToPlace
        }
        Catch {
            Write-Error "Row, Column, and Number must be a number between 1-9, '-hint', or '-solve'"
        }
        If ($OriginalGrid[$Row-1][$Column-1] -ne '-') {
            Write-Error "You cannot modify this number as it is part of the original board."
            Continue
        }
        If (($Row -lt 10 -and $Row -gt 0) -and ($Column -lt 10 -and $Column -gt 0) -and ($NumToPlace -lt 10 -and $NumToPlace -gt 0) ) {
            $Placement = [System.Tuple]::Create($Row, $Column)
            Return @($NumToPlace, $Placement)
        }
        Write-Error "Row, Column, and Number must be between 1-9 (inclusive)"
    }  
}
