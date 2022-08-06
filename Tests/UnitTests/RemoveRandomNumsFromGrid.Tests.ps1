
Describe "RemoveRandomNumsFromGrid" {
    BeforeAll {
        Get-ChildItem -Path ($PSScriptRoot + "\..\..\Private\") | ForEach-Object {
            . $_.FullName
        }
    }
    For ($Script:i = 1; $i -lt 82; $i++) {
        It "Ensure $i numbers remain for $i clues" {
            $Grid = GenerateGrid -Difficulty "Filled"
            $Grid = RemoveRandomNumsFromGrid -SolvedGrid $Grid -NumClues $i
            $ct = 0
            ForEach ($Row in $Grid) {
                ForEach ($Num in $Row) {
                    If ($Num -gt 0) {
                        $ct += 1
                    }
                }   
            }
            $ct | should -be $i
        }
    }
}
