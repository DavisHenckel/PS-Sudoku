# PS-Sudoku
A recursive Sudoku solver written as a PowerShell module.

## Current Version - 1.2.4
Install from the [PowerShell Gallery](https://www.powershellgallery.com/packages/PS-Sudoku/1.2.2)!
```pwsh
Install-Module -Name PS-Sudoku
```
### Instructions
```pwsh
$SudokuBoard = GenerateGrid -Difficulty "Medium"
PrintGrid -SudokuGrid $SudokuBoard
SolveSudoku -SudokuGrid $SudokuBoard
PrintGrid -SudokuGrid $SudokuBoard
```

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
