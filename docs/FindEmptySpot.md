---
external help file: PS-Sudoku-help.xml
Module Name: PS-Sudoku
online version:
schema: 2.0.1
---

# FindEmptySpot

## SYNOPSIS
Finds an available spot to play a number

## SYNTAX

```
FindEmptySpot [-SudokuGrid] <Object> [<CommonParameters>]
```

## DESCRIPTION
Iterates through the entire sudoku board until a spot is found to play.

## EXAMPLES

### EXAMPLE 1
```
FindEmptySpot -SudokuGrid $SudokuGrid
```

## PARAMETERS

### -SudokuGrid
The current Sudoku grid

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

### Takes in a Sudoku grid.
## OUTPUTS

### Returns a tuple that contains the row and column of the empty spot. If there is no empty spot available, returns $null
## NOTES

## RELATED LINKS
