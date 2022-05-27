# PS-Sudoku
A recursive Sudoku solver written as a PowerShell module.

## Current Version - 2.0.1
Install from the [PowerShell Gallery](https://www.powershellgallery.com/packages/PS-Sudoku)!
```pwsh
Install-Module -Name PS-Sudoku
```
### Play Sudoku
There is now an option to play Sudoku! Enter `PlaySudoku` after the module is installed.  
The function can provide a hint, or solve the puzzle given its current state.
### Instructions
```pwsh
# First, generate a sudoku board, specify difficulty of "Easy, Medium, Hard, Expert, Insane, or UniqueSolution"
$SudokuBoard = GenerateGrid -Difficulty "Medium"

# Print the board to see the starting state
PrintGrid -SudokuGrid $SudokuBoard

# Solve the sudoku board. Note that depending on the difficulty of the puzzle, it may take a while. (The unique solution took 3.5 hrs on a 10th gen intel i5 processor)
SolveSudoku -SudokuGrid $SudokuBoard #add the -WatchAlgorithm switch to see the algorithm in action

# After the solver is complete, print the finished Sudoku board!
PrintGrid -SudokuGrid $SudokuBoard
```
## Code Coverage
![CodeCoverage](https://badgen.net/badge/UnitTests/80.15\%/blue?)  
![CodeCoverage](https://badgen.net/badge/IntegrationTests/72.22\%/blue?)  
![CodeCoverage](https://badgen.net/badge/AcceptanceTests/69.82\%/blue?)

## Build Status - Main Branch
| CI System | Environment | Job Name & Status |
| :--- | :--- | :--- |
| GitHub Actions | Windows(v2019 - Current) | ![Build Status](https://github.com/DavisHenckel/PS-Sudoku/actions/workflows/WindowsProd.yml/badge.svg)  |
| GitHub Actions | Ubuntu(v18 - Current) | ![Build Status](https://github.com/DavisHenckel/PS-Sudoku/actions/workflows/LinuxProd.yml/badge.svg) |  
| GitHub Actions | MacOS(v10 - Current) | ![Build Status](https://github.com/DavisHenckel/PS-Sudoku/actions/workflows/MacOSProd.yml/badge.svg)

### Build Status - Development Branch
| CI System | Environment | Job Name & Status |
| :--- | :--- | :--- |
| GitHub Actions | Windows(v2019 - Current) | ![Build Status](https://github.com/DavisHenckel/PS-Sudoku/actions/workflows/WindowsDev.yml/badge.svg)  |
| GitHub Actions | Ubuntu(v18 - Current) | ![Build Status](https://github.com/DavisHenckel/PS-Sudoku/actions/workflows/LinuxDev.yml/badge.svg) |  
| GitHub Actions | MacOS(v10 - Current) | ![Build Status](https://github.com/DavisHenckel/PS-Sudoku/actions/workflows/MacOSDev.yml/badge.svg)
