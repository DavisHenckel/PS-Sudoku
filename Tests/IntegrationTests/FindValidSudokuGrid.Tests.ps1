Describe "FindValidSudokuGrid" {
    BeforeAll {
        Get-ChildItem -Path ($PSScriptRoot + "\..\..\Private\") | ForEach-Object {
            . $_.FullName
        }
    }
    For ($Script:i = 1; $i -lt 82; $i++) {
        It "Find valid Sudoku grid $i clues" {
            $EmptyGrid = GenerateGrid
            $NewGrid = FindValidSudokuGrid -Grid $EmptyGrid -NumClues $i
            $ct = 0
            ForEach ($Row in $NewGrid) {
                ForEach ($Num in $Row) {
                    if ($Num -gt 0) {
                        $ct += 1
                    }
                }   
            }
            $ct | should -be $i
        }
    }
}