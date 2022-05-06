---
external help file: PS-Sudoku-help.xml
Module Name: PS-Sudoku
online version:
schema: 2.0.0
---

# PrintGrid

## SYNOPSIS
Prints a Sudoku grid

## SYNTAX

```
PrintGrid [-SudokuGrid] <Object> [<CommonParameters>]
```

## DESCRIPTION
Prints the current state of the Sudoku grid.

## EXAMPLES

### EXAMPLE 1
```
PrintGrid -Grid $SudokuGrid
```

## PARAMETERS

### -SudokuGrid
The 2D array representing the Sudoku grid.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Takes in a Sudoku grid
## OUTPUTS

### Does not return anything. Simply outputs the Sudoku Board to the console
## NOTES

## RELATED LINKS
