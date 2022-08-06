Describe "SolveSudoku" {
    It "Verifying Easy board solvable" {
        $Count = 0
        $Solved = $false
        While($true) {
            $Grid = GenerateGrid -Difficulty "Easy"
            $Timer =  [system.diagnostics.stopwatch]::StartNew()
            $Solved = SolveSudoku -SudokuGrid $Grid -StopWatch $Timer
            If ($Count -eq 25) {
                Break
            }
            If (-not $Solved) {
                Continue
                $Count += 1
            }
            Break
        }
        $Solved | should -be $true
    }
    It "Verifying Medium board solvable" {
        $Count = 0
        $Solved = $false
        While($true) {
            $Grid = GenerateGrid -Difficulty "Medium"
            $Timer =  [system.diagnostics.stopwatch]::StartNew()
            $Solved = SolveSudoku -SudokuGrid $Grid -StopWatch $Timer
            If ($Count -eq 25) {
                Break
            }
            If (-not $Solved) {
                Continue
                $Count += 1
            }
            Break
        }
        $Solved | should -be $true
    }
    It "Verifying Hard board solvable" {
        $Count = 0
        $Solved = $false
        While($true) {
            $Grid = GenerateGrid -Difficulty "Hard"
            $Timer =  [system.diagnostics.stopwatch]::StartNew()
            $Solved = SolveSudoku -SudokuGrid $Grid -StopWatch $Timer
            If ($Count -eq 25) {
                Break
            }
            If (-not $Solved) {
                Continue
                $Count += 1
            }
            Break
        }
        $Solved | should -be $true
    }
    It "Verifying Expert board solvable" {
        $Count = 0
        $Solved = $false
        While($true) {
            $Grid = GenerateGrid -Difficulty "Expert"
            $Timer =  [system.diagnostics.stopwatch]::StartNew()
            $Solved = SolveSudoku -SudokuGrid $Grid -StopWatch $Timer
            If ($Count -eq 25) {
                Break
            }
            If (-not $Solved) {
                Continue
                $Count += 1
            }
            Break
        }
        $Solved | should -be $true
    }
    It "Verifying Insane board solvable" {
        $Count = 0
        $Solved = $false
        While($true) {
            $Grid = GenerateGrid -Difficulty "Insane"
            $Timer =  [system.diagnostics.stopwatch]::StartNew()
            $Solved = SolveSudoku -SudokuGrid $Grid -StopWatch $Timer
            If ($Count -eq 25) {
                Break
            }
            If (-not $Solved) {
                Continue
                $Count += 1
            }
            Break
        }
        $Solved | should -be $true
    }
}
