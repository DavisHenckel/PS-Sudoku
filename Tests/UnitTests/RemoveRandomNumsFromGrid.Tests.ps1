
Describe "RemoveRandomNumsFromGrid" {
    BeforeAll {
        Get-ChildItem -Path ($PSScriptRoot + "\..\..\Private\") | ForEach-Object {
            . $_.FullName
        }
    }
    It "Ensure 37 numbers remain for easy board" {
        $Grid = GenerateGrid -Difficulty "Filled"
        $Grid = RemoveRandomNumsFromGrid -SolvedGrid $Grid -NumClues 37
        $ct = 0
        ForEach ($Row in $Grid) {
            ForEach ($Num in $Row) {
                if ($Num -gt 0) {
                    $ct += 1
                }
            }   
        }
        $ct | should be 37
    }
    It "Ensure 30 numbers remain for insane board" {
        $Grid = GenerateGrid -Difficulty "Filled"
        $Grid = RemoveRandomNumsFromGrid -SolvedGrid $Grid -NumClues 30
        $ct = 0
        ForEach ($Row in $Grid) {
            ForEach ($Num in $Row) {
                if ($Num -gt 0) {
                    $ct += 1
                }
            }   
        }
        $ct | should be 30
    }
    It "Ensure 23 numbers remain for hard board" {
        $Grid = GenerateGrid -Difficulty "Filled"
        $Grid = RemoveRandomNumsFromGrid -SolvedGrid $Grid -NumClues 23
        $ct = 0
        ForEach ($Row in $Grid) {
            ForEach ($Num in $Row) {
                if ($Num -gt 0) {
                    $ct += 1
                }
            }   
        }
        $ct | should be 23
    }
    It "Ensure 20 numbers remain for expert board" {
        $Grid = GenerateGrid -Difficulty "Filled"
        $Grid = RemoveRandomNumsFromGrid -SolvedGrid $Grid -NumClues 20
        $ct = 0
        ForEach ($Row in $Grid) {
            ForEach ($Num in $Row) {
                if ($Num -gt 0) {
                    $ct += 1
                }
            }   
        }
        $ct | should be 20
    }
    It "Ensure 17 numbers remain for insane board" {
        $Grid = GenerateGrid -Difficulty "Filled"
        $Grid = RemoveRandomNumsFromGrid -SolvedGrid $Grid -NumClues 17
        $ct = 0
        ForEach ($Row in $Grid) {
            ForEach ($Num in $Row) {
                if ($Num -gt 0) {
                    $ct += 1
                }
            }   
        }
        $ct | should be 17
    }
}