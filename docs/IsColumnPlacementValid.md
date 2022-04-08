---
external help file: PowerShell-CICD-help.xml
Module Name: PowerShell-CICD
online version:
schema: 2.0.0
---

# IsColumnPlacementValid

## SYNOPSIS
Determines if a number placement is valid

## SYNTAX

```
IsColumnPlacementValid [-SudokuGrid] <Object> [-Column] <Int32> [-Number] <Int32> [<CommonParameters>]
```

## DESCRIPTION
Based on column and number, determines if the placement is valid.

## EXAMPLES

### EXAMPLE 1
```
IsColumnValidPlacement(Grid, 1, 1) #where 1, 1 is the column and number
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

### -Column
The column of the placement to attempt, this must be in the range 1-9

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

### -Number
The number to be tried, this must be in the range 1-9

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Takes in a Sudoku grid, a column, and a number
## OUTPUTS

### Returns a boolean
## NOTES

## RELATED LINKS
