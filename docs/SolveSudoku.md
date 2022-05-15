---
external help file: PS-Sudoku-help.xml
Module Name: PS-Sudoku
online version:
schema: 2.0.1
---

# SolveSudoku

## SYNOPSIS
Solves a Sudoku puzzle

## SYNTAX

```
SolveSudoku [-SudokuGrid] <Object> [-WatchAlgorithm] [[-StopWatch] <Object>] [<CommonParameters>]
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

### -WatchAlgorithm
{{ Fill WatchAlgorithm Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -StopWatch
A timer that tracks how long the algorithm has been running.
If it takes longer than 60 seconds, return false.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Takes in a Sudoku grid.
## OUTPUTS

### Outputs a boolean value indicating whether the Sudoku grid is solved or not.
## NOTES

## RELATED LINKS
