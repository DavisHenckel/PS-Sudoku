---
external help file: PowerShell-CICD-help.xml
Module Name: PowerShell-CICD
online version:
schema: 2.0.0
---

# SolveSudoku

## SYNOPSIS
Solves a Sudoku puzzle

## SYNTAX

```
SolveSudoku [-SudokuGrid] <Object> [[-PrintSolution] <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Completes the Sudoku Puzzle if there is any solution by recursively calling itself until completion.

## EXAMPLES

### EXAMPLE 1
```
SolveSudoku -SudokuGrid $SudokuGrid
```

## PARAMETERS

### -SudokuGrid
The current state Sudoku grid, this is modified on each call.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrintSolution
{{ Fill PrintSolution Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Takes in a Sudoku grid.
## OUTPUTS

### Prints the state of the puzzle on each call. Prints success message when completed and returns $true.
## NOTES

## RELATED LINKS
