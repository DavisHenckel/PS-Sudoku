Describe "SolveSudoku" {
    It "Verifying Easy board solvable" {
        $Count = 0
        $Solved = $false
        while($true) {
            $Grid = GenerateGrid -Difficulty "Easy"
            $Timer =  [system.diagnostics.stopwatch]::StartNew()
            $Solved = SolveSudoku -SudokuGrid $Grid -StopWatch $Timer
            if ($Count -eq 25) {
                break
            }
            if (-not $Solved) {
                continue
                $Count += 1
            }
            break
        }
        $Solved | should -be $true
    }
    It "Verifying Medium board solvable" {
        $Count = 0
        $Solved = $false
        while($true) {
            $Grid = GenerateGrid -Difficulty "Medium"
            $Timer =  [system.diagnostics.stopwatch]::StartNew()
            $Solved = SolveSudoku -SudokuGrid $Grid -StopWatch $Timer
            if ($Count -eq 25) {
                break
            }
            if (-not $Solved) {
                continue
                $Count += 1
            }
            break
        }
        $Solved | should -be $true
    }
    It "Verifying Hard board solvable" {
        $Count = 0
        $Solved = $false
        while($true) {
            $Grid = GenerateGrid -Difficulty "Hard"
            $Timer =  [system.diagnostics.stopwatch]::StartNew()
            $Solved = SolveSudoku -SudokuGrid $Grid -StopWatch $Timer
            if ($Count -eq 25) {
                break
            }
            if (-not $Solved) {
                continue
                $Count += 1
            }
            break
        }
        $Solved | should -be $true
    }
    It "Verifying Expert board solvable" {
        $Count = 0
        $Solved = $false
        while($true) {
            $Grid = GenerateGrid -Difficulty "Expert"
            $Timer =  [system.diagnostics.stopwatch]::StartNew()
            $Solved = SolveSudoku -SudokuGrid $Grid -StopWatch $Timer
            if ($Count -eq 25) {
                break
            }
            if (-not $Solved) {
                continue
                $Count += 1
            }
            break
        }
        $Solved | should -be $true
    }
    It "Verifying Insane board solvable" {
        $Count = 0
        $Solved = $false
        while($true) {
            $Grid = GenerateGrid -Difficulty "Insane"
            $Timer =  [system.diagnostics.stopwatch]::StartNew()
            $Solved = SolveSudoku -SudokuGrid $Grid -StopWatch $Timer
            if ($Count -eq 25) {
                break
            }
            if (-not $Solved) {
                continue
                $Count += 1
            }
            break
        }
        $Solved | should -be $true
    }
}