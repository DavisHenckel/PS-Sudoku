---
external help file: PS-Sudoku-help.xml
Module Name: PS-Sudoku
online version:
schema: 2.0.1
---

# GenerateGrid

## SYNOPSIS
Generates a 2D Arraylist that represents the Sudoku board.

## SYNTAX

```
GenerateGrid [[-Difficulty] <String>] [<CommonParameters>]
```

## DESCRIPTION
By Default, will generate an Empty 2D array that will be used for the Sudoku Board.
Allows for optional parameters that will give the user the ability to generate a Sudoku Board with a specified difficulty.

## EXAMPLES

### EXAMPLE 1
```
$SudokuBoard = GenerateGrid
```

### EXAMPLE 2
```
$SudokuBoard = GenerateGrid -Difficulty "Easy" #will provide 37 random clues
```

### EXAMPLE 3
```
$SudokuBoard = GenerateGrid -Difficulty "Medium" #will provide 30 random clues
```

### EXAMPLE 4
```
$SudokuBoard = GenerateGrid -Difficulty "Hard" #will provide 23 random clues
```

### EXAMPLE 5
```
$SudokuBoard = GenerateGrid -Difficulty "Expert" #will provide 20 random clues
```

### EXAMPLE 6
```
$SudokuBoard = GenerateGrid -Difficulty "Insane" #will provide 17 random clues
```

## PARAMETERS

### -Difficulty
The difficulty of the Sudoku Board.
This must be in the set "Filled", "Empty", "Easy", "Medium", "Hard", "Expert", or "Insane" where easy-insane is 37,3'-',23,2'-',17 number of clues respectively
Empty is the default and will generate an empty board of all '-'.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Empty
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Returns a 2D array that is the Sudoku Board.
## NOTES

## RELATED LINKS
