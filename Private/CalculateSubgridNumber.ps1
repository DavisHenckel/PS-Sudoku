<#
.SYNOPSIS
    Determines the subgrid number of the current placement attempt
.DESCRIPTION
    Based on row and column, determines the .
.PARAMETER Row
    The row of the placement to attempt, this must be in the range 1-9
.PARAMETER Column
    The number to be tried, must be in the range 1-9
.EXAMPLE
    CaclulateSubgrid -Row 1 -Column 1 #would return 0th subgrid
.INPUTS
    Takes in a row and column
.OUTPUTS
    Returns a number indicating the subgrid number
#>
Function CalculateSubgridNumber {
    param (
        [parameter(Mandatory=$true)]
        [ValidateRange(1, 9)]
        [int32]$Row,
        [parameter(Mandatory=$true)]
        [ValidateRange(1, 9)]
        [int32]$Column
    )
    if ($Row -lt 4) { # in the first row of subgrids
        if ($Column -lt 4) { # in the first column of subgrids
            return 0
        }
        elseif ($Column -lt 7) { # in the second column of subgrids
            return 1
        }
        else { # in the third column of subgrids
            return 2
        }
    }
    elseif ($Row -lt 7) { #in the 2nd row of subgrids
        if ($Column -lt 4) { # in the first column of subgrids
            return 3
        }
        elseif ($Column -lt 7) { # in the second column of subgrids
            return 4
        }
        else { # in the third column of subgrids
            return 5
        }
    }
    else { #in the 3rd row of subgrids
        if ($Column -lt 4) { # in the first column of subgrids
            return 6
        }
        elseif ($Column -lt 7) { # in the second column of subgrids
            return 7
        }
        else { # in the third column of subgrids
            return 8
        }
    } 
}