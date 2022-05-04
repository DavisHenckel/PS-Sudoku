---
external help file: PS-Sudoku-help.xml
Module Name: PS-Sudoku
online version:
schema: 2.0.0
---

# IsMoveValid

## SYNOPSIS
Determines if a sudoku move is valid

## SYNTAX

```
IsMoveValid [-SudokuGrid] <Object> [-Row] <Int32> [-Column] <Int32> [-Number] <Int32> [<CommonParameters>]
```

## DESCRIPTION
Accounts for all 3 possible scenarios where a move could be invalid

## EXAMPLES

### EXAMPLE 1
```
IsMoveValid -SudokuGrid SudokuGrid -Row 1 -Column 1 -Number 1
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

### -Row
The row of the placement to attempt, this must be in the range 1-9

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Column
The column of the placement to attempt, this must be in the range 1-9

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Number
The number to be tried, this must be in the range 1-9

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Takes in a Sudoku grid, a row, a column, and a number
## OUTPUTS

### Returns a boolean value indicating if the move is valid
## NOTES

## RELATED LINKS
