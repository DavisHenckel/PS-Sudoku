function New-SudokuForm {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [System.Object]$SudokuGrid = $(GenerateGrid -Difficulty Empty)
    )

    begin {
        function New-SudokuGame {
            [CmdletBinding()]
            param(
                [Parameter(Mandatory=$true)]
                [System.Windows.Forms.TableLayoutPanel]$SudokuTable,
                [Parameter(Mandatory=$true)]
                [string]$Difficulty
            )
            $SudokuGrid = GenerateGrid -Difficulty $Difficulty
            Set-SudokuGrid -SudokuTable $SudokuTable -SudokuGrid $SudokuGrid
        }

        function Get-SudokuHint {
            [CmdletBinding()]
            param(
                [Parameter(Mandatory=$true)]
                [System.Windows.Forms.TableLayoutPanel]$SudokuTable
            )
            $SudokuGrid = ConvertTo-SudokuGrid -SudokuTable $SudokuTable
            $CurrentState = DeepCopyArray -Source $SudokuGrid
            $Solvable = SolveSudoku -SudokuGrid $CurrentState
            if ($Solvable) {
                $EmptySpot = FindEmptySpot -SudokuGrid $SudokuGrid
                $Hint = $CurrentState[($EmptySpot.Item1)-1][($EmptySpot.Item2)-1]
                [System.Windows.Forms.MessageBox]::Show("Place $Hint at row:$($EmptySpot.Item1), col:$($EmptySpot.Item2)")
                return $null

            } else {
                [System.Windows.Forms.MessageBox]::Show("The current state of your puzzle is not solvable.")
                return $null
            }
        }

        function Get-SudokuSolved {
            [CmdletBinding()]
            param(
                [Parameter(Mandatory=$true)]
                [System.Windows.Forms.TableLayoutPanel]$SudokuTable
            )
            $SudokuGrid = ConvertTo-SudokuGrid -SudokuTable $SudokuTable
            SolveSudoku -SudokuGrid $SudokuGrid
            Set-SudokuGrid -SudokuTable $SudokuTable -SudokuGrid $SudokuGrid
        }

        function Set-SudokuGrid {
            [CmdletBinding()]
            param(
                [Parameter(Mandatory=$true)]
                [System.Windows.Forms.TableLayoutPanel]$SudokuTable,
                [Parameter(Mandatory=$true)]
                [System.Object]$SudokuGrid
            )
            $Iterator = 0
            $RowIterator = 0
            foreach ( $Control in $SudokuTable.Controls ) {
                $Row = $SudokuGrid.Item($RowIterator)
                $Control.Text = $Row[$Iterator] -replace '-',' '
                $Iterator += 1
                if ($Iterator -eq 9) {
                    $Iterator = 0
                    $RowIterator += 1
                }
            }
            return $null
        }

        function Set-SudokuTable {
            [CmdletBinding()]
            param(
                [Parameter(Mandatory=$true)]
                [System.Windows.Forms.TableLayoutPanel]$SudokuTable,
                [Parameter(Mandatory=$true)]
                [System.Windows.Forms.TableLayoutPanel]$CustomSudokuTable
            )
            $Iterator = 0
            foreach ( $Control in $SudokuTable.Controls ) {
                $Control.Text = $CustomSudokuTable.Controls[$Iterator].Text -replace '-',' '
                $Iterator += 1
            }
            return $null
        }

        function ConvertTo-SudokuGrid {
            [CmdletBinding()]
            param(
                [Parameter(Mandatory=$true)]
                [System.Windows.Forms.TableLayoutPanel]$SudokuTable
            )

            $SudokuGrid = [System.Array]@(
                [System.Array]@('-','-','-','-','-','-','-','-','-'),
                [System.Array]@('-','-','-','-','-','-','-','-','-'),
                [System.Array]@('-','-','-','-','-','-','-','-','-'),
                [System.Array]@('-','-','-','-','-','-','-','-','-'),
                [System.Array]@('-','-','-','-','-','-','-','-','-'),
                [System.Array]@('-','-','-','-','-','-','-','-','-'),
                [System.Array]@('-','-','-','-','-','-','-','-','-'),
                [System.Array]@('-','-','-','-','-','-','-','-','-'),
                [System.Array]@('-','-','-','-','-','-','-','-','-')
            )
            $NewRow = ('-','-','-','-','-','-','-','-','-')
            $Iterator = 0
            $RowIterator = 0
            foreach ( $Control in $SudokuTable.Controls ) {
                if ( $Iterator -eq 8 ) {
                    $null = $NewRow.SetValue($($Control.Text -replace ' ','-'),$Iterator)
                    $Iterator = 0
                    $SudokuGrid.Item($RowIterator) = $($NewRow)
                    $RowIterator += 1
                } else {
                    $null = $NewRow.SetValue($($Control.Text -replace ' ','-'),$Iterator)
                    $Iterator += 1
                }
            }
            return $SudokuGrid
        }

        # Assemblies
        Add-Type -AssemblyName System.Drawing
        Add-Type -AssemblyName System.Windows.Forms

        # Form
        $Form = [System.Windows.Forms.Form]::new()
        $Form.Name = "Form"
        $Form.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
        $Form.Text = "PS-Sudoku"
        $Form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen

        # Outer/MiddleLayer are used to center everything inside the Form
        $OuterLayer = [System.Windows.Forms.TableLayoutPanel]::new()
        $OuterLayer.Name = "OuterLayer"
        $OuterLayer.AutoSize = $true
        $OuterLayer.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
        $OuterLayer.Padding = [System.Windows.Forms.Padding]::new(0)
        $OuterLayer.Margin = [System.Windows.Forms.Padding]::new(0)
        $OuterLayer.Dock = [System.Windows.Forms.DockStyle]::Top
        $OuterLayer.ColumnCount = 1
        $OuterLayer.RowCount = 1

        $MiddleLayer = [System.Windows.Forms.FlowLayoutPanel]::new()
        $MiddleLayer.Name = "MiddleLayer"
        $MiddleLayer.AutoSize = $true
        $MiddleLayer.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
        $MiddleLayer.Padding = [System.Windows.Forms.Padding]::new(0)
        $MiddleLayer.Margin = [System.Windows.Forms.Padding]::new(0)
        $MiddleLayer.Anchor = [System.Windows.Forms.AnchorStyles]::Top
        $MiddleLayer.FlowDirection = [System.Windows.Forms.FlowDirection]::LeftToRight


        # SudokuTable used to hold the SudokuGrid
        $SudokuTable = [System.Windows.Forms.TableLayoutPanel]::new()
        $SudokuTable.Name = "SudokuTable"
        $SudokuTable.AutoSize = $true
        $SudokuTable.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
        $SudokuTable.Padding = [System.Windows.Forms.Padding]::new(5)
        $SudokuTable.Margin = [System.Windows.Forms.Padding]::new(5)
        $SudokuTable.Dock = [System.Windows.Forms.DockStyle]::Top
        $SudokuTable.BackColor = [System.Drawing.Color]::Black
        $SudokuTable.CellBorderStyle = [System.Windows.Forms.TableLayoutPanelCellBorderStyle]::Single
        $SudokuTable.ColumnCount = 9
        $SudokuTable.RowCount = 9
        $SudokuTable.Visible = $true

        # CustomSudokuTable used to hold the Temporary SudokuGrid
        $CustomSudokuTable = [System.Windows.Forms.TableLayoutPanel]::new()
        $CustomSudokuTable.Name = "CustomSudokuTable"
        $CustomSudokuTable.AutoSize = $true
        $CustomSudokuTable.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
        $CustomSudokuTable.Padding = [System.Windows.Forms.Padding]::new(5)
        $CustomSudokuTable.Margin = [System.Windows.Forms.Padding]::new(5)
        $CustomSudokuTable.Dock = [System.Windows.Forms.DockStyle]::Top
        $CustomSudokuTable.BackColor = [System.Drawing.Color]::Black
        $CustomSudokuTable.CellBorderStyle = [System.Windows.Forms.TableLayoutPanelCellBorderStyle]::Single
        $CustomSudokuTable.ColumnCount = 9
        $CustomSudokuTable.RowCount = 9
        $CustomSudokuTable.Visible = $false

        # ButtonTable used to hold gameplay buttons
        $ButtonTable = [System.Windows.Forms.TableLayoutPanel]::new()
        $ButtonTable.Name = "ButtonTable"
        $ButtonTable.AutoSize = $true
        $ButtonTable.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
        $ButtonTable.Padding = [System.Windows.Forms.Padding]::new(5)
        $ButtonTable.Margin = [System.Windows.Forms.Padding]::new(5)
        $ButtonTable.Dock = [System.Windows.Forms.DockStyle]::Top
        $ButtonTable.ColumnCount = 1
        $ButtonTable.RowCount = 4
        $ButtonTable.Visible = $true

        # ConfirmButtonTable used to hold Save/Cancel buttons
        $ConfirmButtonTable = [System.Windows.Forms.TableLayoutPanel]::new()
        $ConfirmButtonTable.Name = "ConfirmButtonTable"
        $ConfirmButtonTable.AutoSize = $true
        $ConfirmButtonTable.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
        $ConfirmButtonTable.Padding = [System.Windows.Forms.Padding]::new(5)
        $ConfirmButtonTable.Margin = [System.Windows.Forms.Padding]::new(5)
        $ConfirmButtonTable.Dock = [System.Windows.Forms.DockStyle]::Top
        $ConfirmButtonTable.ColumnCount = 1
        $ConfirmButtonTable.RowCount = 2
        $ConfirmButtonTable.Visible = $false

        # DifficultyButtonTable used to hold Diffculty buttons
        $DifficultyButtonTable = [System.Windows.Forms.TableLayoutPanel]::new()
        $DifficultyButtonTable.Name = "DifficultyButtonTable"
        $DifficultyButtonTable.AutoSize = $true
        $DifficultyButtonTable.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
        $DifficultyButtonTable.Padding = [System.Windows.Forms.Padding]::new(5)
        $DifficultyButtonTable.Margin = [System.Windows.Forms.Padding]::new(5)
        $DifficultyButtonTable.Dock = [System.Windows.Forms.DockStyle]::Top
        $DifficultyButtonTable.ColumnCount = 1
        $DifficultyButtonTable.RowCount = 6
        $DifficultyButtonTable.Visible = $false

        # Buttons
        $NewGameButton = [System.Windows.Forms.Button]::new()
        $NewGameButton.Name = "NewGameButton"
        $NewGameButton.AutoSize = $true
        $NewGameButton.Padding = [System.Windows.Forms.Padding]::new(0)
        $NewGameButton.Margin = [System.Windows.Forms.Padding]::new(0)
        $NewGameButton.Dock = [System.Windows.Forms.DockStyle]::Top
        $NewGameButton.Text = "New Game"
        $NewGameButton.TextAlign = [System.Windows.Forms.HorizontalAlignment]::Center
        $NewGameButton.Font = [System.Drawing.Font]::new( "Verdana" , 12 )
        $NewGameButton.Add_Click({
            $ButtonTable.Visible = $false
            $DifficultyButtonTable.Visible = $true
        })

        $HintButton = [System.Windows.Forms.Button]::new()
        $HintButton.Name = "HintButton"
        $HintButton.AutoSize = $true
        $HintButton.Padding = [System.Windows.Forms.Padding]::new(0)
        $HintButton.Margin = [System.Windows.Forms.Padding]::new(0)
        $HintButton.Dock = [System.Windows.Forms.DockStyle]::Top
        $HintButton.Text = "Hint"
        $HintButton.TextAlign = [System.Windows.Forms.HorizontalAlignment]::Center
        $HintButton.Font = [System.Drawing.Font]::new( "Verdana" , 12 )
        $HintButton.Add_Click({
            $StatusLabel.Text = "Getting Hint..."
            $StatusLabel.Visible = $true
            $Form.Refresh()
            Get-SudokuHint -SudokuTable $SudokuTable
            $StatusLabel.Visible = $false
            $StatusLabel.Text = ""
        })

        $SolveButton = [System.Windows.Forms.Button]::new()
        $SolveButton.Name = "SolveButton"
        $SolveButton.AutoSize = $true
        $SolveButton.Padding = [System.Windows.Forms.Padding]::new(0)
        $SolveButton.Margin = [System.Windows.Forms.Padding]::new(0)
        $SolveButton.Dock = [System.Windows.Forms.DockStyle]::Top
        $SolveButton.Text = "Solve"
        $SolveButton.TextAlign = [System.Windows.Forms.HorizontalAlignment]::Center
        $SolveButton.Font = [System.Drawing.Font]::new( "Verdana" , 12 )
        $SolveButton.Add_Click({
            $StatusLabel.Text = "Solving Sudoku..."
            $StatusLabel.Visible = $true
            $Form.Refresh()
            Get-SudokuSolved -SudokuTable $SudokuTable
            $StatusLabel.Visible = $false
            $StatusLabel.Text = ""
        })

        $CustomGridButton = [System.Windows.Forms.Button]::new()
        $CustomGridButton.Name = "CustomGridButton"
        $CustomGridButton.AutoSize = $true
        $CustomGridButton.Padding = [System.Windows.Forms.Padding]::new(0)
        $CustomGridButton.Margin = [System.Windows.Forms.Padding]::new(0)
        $CustomGridButton.Dock = [System.Windows.Forms.DockStyle]::Top
        $CustomGridButton.Text = "Custom Grid"
        $CustomGridButton.TextAlign = [System.Windows.Forms.HorizontalAlignment]::Center
        $CustomGridButton.Font = [System.Drawing.Font]::new( "Verdana" , 12 )
        $CustomGridButton.Add_Click({
            $SudokuTable.Visible = $false
            $ButtonTable.Visible = $false
            $CustomSudokuTable.Visible = $true
            $ConfirmButtonTable.Visible = $true
        })

        # Difficulty Buttons
        $EasyButton = [System.Windows.Forms.Button]::new()
        $EasyButton.Name = "EasyButton"
        $EasyButton.AutoSize = $true
        $EasyButton.Padding = [System.Windows.Forms.Padding]::new(0)
        $EasyButton.Margin = [System.Windows.Forms.Padding]::new(0)
        $EasyButton.Dock = [System.Windows.Forms.DockStyle]::Top
        $EasyButton.Text = "Easy"
        $EasyButton.TextAlign = [System.Windows.Forms.HorizontalAlignment]::Center
        $EasyButton.Font = [System.Drawing.Font]::new( "Verdana" , 12 )
        $EasyButton.Add_Click({
            $StatusLabel.Text = "Generating Sudoku..."
            $StatusLabel.Visible = $true
            $Form.Refresh()
            New-SudokuGame -SudokuTable $SudokuTable -Difficulty "Easy"
            $DifficultyButtonTable.Visible = $false
            $ButtonTable.Visible = $true
            $StatusLabel.Visible = $false
            $StatusLabel.Text = ""
        })

        $MediumButton = [System.Windows.Forms.Button]::new()
        $MediumButton.Name = "MediumButton"
        $MediumButton.AutoSize = $true
        $MediumButton.Padding = [System.Windows.Forms.Padding]::new(0)
        $MediumButton.Margin = [System.Windows.Forms.Padding]::new(0)
        $MediumButton.Dock = [System.Windows.Forms.DockStyle]::Top
        $MediumButton.Text = "Medium"
        $MediumButton.TextAlign = [System.Windows.Forms.HorizontalAlignment]::Center
        $MediumButton.Font = [System.Drawing.Font]::new( "Verdana" , 12 )
        $MediumButton.Add_Click({
            $StatusLabel.Text = "Generating Sudoku..."
            $StatusLabel.Visible = $true
            $Form.Refresh()
            New-SudokuGame -SudokuTable $SudokuTable -Difficulty "Medium"
            $DifficultyButtonTable.Visible = $false
            $ButtonTable.Visible = $true
            $StatusLabel.Visible = $false
            $StatusLabel.Text = ""
        })

        $HardButton = [System.Windows.Forms.Button]::new()
        $HardButton.Name = "SolveButton"
        $HardButton.AutoSize = $true
        $HardButton.Padding = [System.Windows.Forms.Padding]::new(0)
        $HardButton.Margin = [System.Windows.Forms.Padding]::new(0)
        $HardButton.Dock = [System.Windows.Forms.DockStyle]::Top
        $HardButton.Text = "Hard"
        $HardButton.TextAlign = [System.Windows.Forms.HorizontalAlignment]::Center
        $HardButton.Font = [System.Drawing.Font]::new( "Verdana" , 12 )
        $HardButton.Add_Click({
            $StatusLabel.Text = "Generating Sudoku..."
            $StatusLabel.Visible = $true
            $Form.Refresh()
            New-SudokuGame -SudokuTable $SudokuTable -Difficulty "Hard"
            $DifficultyButtonTable.Visible = $false
            $ButtonTable.Visible = $true
            $StatusLabel.Visible = $false
            $StatusLabel.Text = ""
        })

        $ExpertButton = [System.Windows.Forms.Button]::new()
        $ExpertButton.Name = "ExpertButton"
        $ExpertButton.AutoSize = $true
        $ExpertButton.Padding = [System.Windows.Forms.Padding]::new(0)
        $ExpertButton.Margin = [System.Windows.Forms.Padding]::new(0)
        $ExpertButton.Dock = [System.Windows.Forms.DockStyle]::Top
        $ExpertButton.Text = "Expert"
        $ExpertButton.TextAlign = [System.Windows.Forms.HorizontalAlignment]::Center
        $ExpertButton.Font = [System.Drawing.Font]::new( "Verdana" , 12 )
        $ExpertButton.Add_Click({
            $StatusLabel.Text = "Generating Sudoku..."
            $StatusLabel.Visible = $true
            $Form.Refresh()
            New-SudokuGame -SudokuTable $SudokuTable -Difficulty "Expert"
            $DifficultyButtonTable.Visible = $false
            $ButtonTable.Visible = $true
            $StatusLabel.Visible = $false
            $StatusLabel.Text = ""
        })

        $InsaneButton = [System.Windows.Forms.Button]::new()
        $InsaneButton.Name = "InsaneButton"
        $InsaneButton.AutoSize = $true
        $InsaneButton.Padding = [System.Windows.Forms.Padding]::new(0)
        $InsaneButton.Margin = [System.Windows.Forms.Padding]::new(0)
        $InsaneButton.Dock = [System.Windows.Forms.DockStyle]::Top
        $InsaneButton.Text = "Insane"
        $InsaneButton.TextAlign = [System.Windows.Forms.HorizontalAlignment]::Center
        $InsaneButton.Font = [System.Drawing.Font]::new( "Verdana" , 12 )
        $InsaneButton.Add_Click({
            $StatusLabel.Text = "Generating Sudoku..."
            $StatusLabel.Visible = $true
            $Form.Refresh()
            New-SudokuGame -SudokuTable $SudokuTable -Difficulty "Insane"
            $DifficultyButtonTable.Visible = $false
            $ButtonTable.Visible = $true
            $StatusLabel.Visible = $false
            $StatusLabel.Text = ""
        })

        $DifficultyCancelButton = [System.Windows.Forms.Button]::new()
        $DifficultyCancelButton.Name = "DifficultyCancelButton"
        $DifficultyCancelButton.AutoSize = $true
        $DifficultyCancelButton.Padding = [System.Windows.Forms.Padding]::new(0)
        $DifficultyCancelButton.Margin = [System.Windows.Forms.Padding]::new(0)
        $DifficultyCancelButton.Dock = [System.Windows.Forms.DockStyle]::Top
        $DifficultyCancelButton.Text = "Cancel"
        $DifficultyCancelButton.TextAlign = [System.Windows.Forms.HorizontalAlignment]::Center
        $DifficultyCancelButton.Font = [System.Drawing.Font]::new( "Verdana" , 12 )
        $DifficultyCancelButton.Add_Click({
            $DifficultyButtonTable.Visible = $false
            $ButtonTable.Visible = $true
        })

        # Confirm Buttons
        $SaveButton = [System.Windows.Forms.Button]::new()
        $SaveButton.Name = "SaveButton"
        $SaveButton.AutoSize = $true
        $SaveButton.Padding = [System.Windows.Forms.Padding]::new(0)
        $SaveButton.Margin = [System.Windows.Forms.Padding]::new(0)
        $SaveButton.Dock = [System.Windows.Forms.DockStyle]::Top
        $SaveButton.Text = "Save"
        $SaveButton.TextAlign = [System.Windows.Forms.HorizontalAlignment]::Center
        $SaveButton.Font = [System.Drawing.Font]::new( "Verdana" , 12 )
        $SaveButton.Add_Click({
            $CustomSudokuTable.Visible = $false
            $ConfirmButtonTable.Visible = $false
            Set-SudokuTable -SudokuTable $SudokuTable -CustomSudokuTable $CustomSudokuTable
            $SudokuTable.Visible = $true
            $ButtonTable.Visible = $true
            ForEach ($Control in $CustomSudokuTable.Controls) {
                $Control.Text = ""
            }
        })

        $CancelButton = [System.Windows.Forms.Button]::new()
        $CancelButton.Name = "CancelButton"
        $CancelButton.AutoSize = $true
        $CancelButton.Padding = [System.Windows.Forms.Padding]::new(0)
        $CancelButton.Margin = [System.Windows.Forms.Padding]::new(0)
        $CancelButton.Dock = [System.Windows.Forms.DockStyle]::Top
        $CancelButton.Text = "Cancel"
        $CancelButton.TextAlign = [System.Windows.Forms.HorizontalAlignment]::Center
        $CancelButton.Font = [System.Drawing.Font]::new( "Verdana" , 12 )
        $CancelButton.Add_Click({
            $CustomSudokuTable.Visible = $false
            $ConfirmButtonTable.Visible = $false

            $SudokuTable.Visible = $true
            $ButtonTable.Visible = $true

            ForEach ($Control in $CustomSudokuTable.Controls) {
                $Control.Text = ""
            }
        })

        # Labels
        $StatusLabel = [System.Windows.Forms.Label]::new()
        $StatusLabel.Name = "StatusLabel"
        $StatusLabel.AutoSize = $true
        $StatusLabel.Padding = [System.Windows.Forms.Padding]::new(0)
        $StatusLabel.Margin = [System.Windows.Forms.Padding]::new(0)
        $StatusLabel.Dock = [System.Windows.Forms.DockStyle]::Fill
        $StatusLabel.Text = ""
        $StatusLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
        $StatusLabel.Font = [System.Drawing.Font]::new( "Verdana", 12 )
        $StatusLabel.Visible = $false

        # Add Controls
        $null = $Form.Controls.Add($OuterLayer)
        $null = $OuterLayer.Controls.Add($MiddleLayer)
        $null = $MiddleLayer.Controls.Add($SudokuTable)
        $null = $MiddleLayer.Controls.Add($CustomSudokuTable)
        $null = $MiddleLayer.Controls.Add($ButtonTable)
        $null = $MiddleLayer.Controls.Add($ConfirmButtonTable)
        $null = $MiddleLayer.Controls.Add($DifficultyButtonTable)
        $null = $MiddleLayer.Controls.Add($StatusLabel)
        $null = $MiddleLayer.SetFlowBreak($DifficultyButtonTable,$true)
        $null = $ButtonTable.Controls.Add($NewGameButton)
        $null = $ButtonTable.Controls.Add($HintButton)
        $null = $ButtonTable.Controls.Add($SolveButton)
        $null = $ButtonTable.Controls.Add($CustomGridButton)
        $null = $ConfirmButtonTable.Controls.Add($SaveButton)
        $null = $ConfirmButtonTable.Controls.Add($CancelButton)
        $null = $DifficultyButtonTable.Controls.Add($EasyButton)
        $null = $DifficultyButtonTable.Controls.Add($MediumButton)
        $null = $DifficultyButtonTable.Controls.Add($HardButton)
        $null = $DifficultyButtonTable.Controls.Add($ExpertButton)
        $null = $DifficultyButtonTable.Controls.Add($InsaneButton)
        $null = $DifficultyButtonTable.Controls.Add($DifficultyCancelButton)
    }

    process {
        # Sudoku Labels
        $Offset = 1
        $RowIterator = 1
        foreach ($Row in $SudokuGrid) {
            $ColumnIterator = 1
            foreach ($Column in $Row) {
                # SudokuTable
                try {
                    New-Variable -Name "R$($RowIterator)C$($ColumnIterator)" -Value $( [System.Windows.Forms.Label]::new() ) -ErrorAction Stop
                } catch {
                    Remove-Variable -Name "R$($RowIterator)C$($ColumnIterator)" -Force
                    New-Variable -Name "R$($RowIterator)C$($ColumnIterator)" -Value $( [System.Windows.Forms.Label]::new() )
                }
                $Width = 50
                $Height = 50
                $Left = 0
                $Top = 0
                $Right = 0
                $Bottom = 0
                if ( $RowIterator -match '[36]') {
                    $Bottom = $Offset
                    $Height += $Offset
                }
                elseif ( $RowIterator -match '[47]' ) {
                    $Top = $Offset
                    $Height += $Offset
                }
                if ( $ColumnIterator -match '[36]' ) {
                    $Right = $Offset
                    $Width += $Offset
                }
                elseif ( $ColumnIterator -match '[47]' ) {
                    $Left = $Offset
                    $Width += $Offset
                }
                $(Get-Variable -Name "R$($RowIterator)C$($ColumnIterator)" -ValueOnly).Name = "R$($RowIterator)C$($ColumnIterator)"
                $(Get-Variable -Name "R$($RowIterator)C$($ColumnIterator)" -ValueOnly).Size = [System.Drawing.Size]::new( $Width, $Height )
                $(Get-Variable -Name "R$($RowIterator)C$($ColumnIterator)" -ValueOnly).Padding = [System.Windows.Forms.Padding]::new( $Left, $Top, $Right, $Bottom )
                $(Get-Variable -Name "R$($RowIterator)C$($ColumnIterator)" -ValueOnly).Margin = [System.Windows.Forms.Padding]::new( $Left, $Top, $Right, $Bottom )
                $(Get-Variable -Name "R$($RowIterator)C$($ColumnIterator)" -ValueOnly).Text = $Column -replace '[^1-9]',' '
                $(Get-Variable -Name "R$($RowIterator)C$($ColumnIterator)" -ValueOnly).TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
                $(Get-Variable -Name "R$($RowIterator)C$($ColumnIterator)" -ValueOnly).Font = [System.Drawing.Font]::new( "Verdana", 12 )
                $(Get-Variable -Name "R$($RowIterator)C$($ColumnIterator)" -ValueOnly).BackColor = [System.Drawing.Color]::White
                $(Get-Variable -Name "R$($RowIterator)C$($ColumnIterator)" -ValueOnly).ForeColor = [System.Drawing.Color]::Black
                $(Get-Variable -Name "R$($RowIterator)C$($ColumnIterator)" -ValueOnly).Add_Click({
                    $this.Focus()
                })
                $(Get-Variable -Name "R$($RowIterator)C$($ColumnIterator)" -ValueOnly).Add_KeyDown({
                    $CurrentSudokuRow = ($this.Name -replace '[^1-9]','').Substring(0,1)
                    $CurrentSudokuColumn = ($this.Name -replace '[^1-9]','').Substring(1,1)
                    if ((( $_.KeyCode -replace '[^1-9]','' ) -match '[1-9]' ) -and (( $this.Text -notmatch '[1-9]' ) -or ( $this.ForeColor -eq [System.Drawing.Color]::Blue ))) {
                        $CurrentSudokuGrid = ConvertTo-SudokuGrid -SudokuTable $SudokuTable
                        if ( IsMoveValid -SudokuGrid $CurrentSudokuGrid -Row $CurrentSudokuRow -Column $CurrentSudokuColumn -Number $($_.KeyCode -replace '[^1-9]') ) {
                            $this.Text = $_.KeyCode -replace '[^1-9]',''
                            $this.ForeColor = [System.Drawing.Color]::Blue
                            if ($CurrentSudokuColumn -le 8) {
                                $NextSudokuRow = [int32]$CurrentSudokuRow
                                $NextSudokuColumn = [int32]$CurrentSudokuColumn + 1
                            } elseif ($CurrentSudokuRow -le 8) {
                                $NextSudokuRow = [int32]$CurrentSudokuRow + 1
                                $NextSudokuColumn = 1
                            } else {
                                $NextSudokuRow = 1
                                $NextSudokuColumn = 1
                            }
                            $(Get-Variable -Name "R$($NextSudokuRow)C$($NextSudokuColumn)" -ValueOnly).Focus()
                        }
                    } elseif ($_.KeyCode -eq "Back") {
                        $this.Text = ""
                        $this.ForeColor -eq [System.Drawing.Color]::Black
                        if ($CurrentSudokuColumn -ge 2) {
                            $NextSudokuRow = [int32]$CurrentSudokuRow
                            $NextSudokuColumn = [int32]$CurrentSudokuColumn - 1
                        } elseif ($CurrentSudokuRow -ge 2) {
                            $NextSudokuRow = [int32]$CurrentSudokuRow - 1
                            $NextSudokuColumn = 9
                        } else {
                            $NextSudokuRow = 9
                            $NextSudokuColumn = 9
                        }
                        $(Get-Variable -Name "R$($NextSudokuRow)C$($NextSudokuColumn)" -ValueOnly).Focus()
                    }
                })
                $(Get-Variable -Name "R$($RowIterator)C$($ColumnIterator)" -ValueOnly).Add_GotFocus({
                    $this.BackColor = [System.Drawing.Color]::LightGray
                })
                $(Get-Variable -Name "R$($RowIterator)C$($ColumnIterator)" -ValueOnly).Add_LostFocus({
                    $this.BackColor = [System.Drawing.Color]::White
                })

                $null = $SudokuTable.Controls.Add($(Get-Variable -Name "R$($RowIterator)C$($ColumnIterator)" -ValueOnly))

                # CustomSudokuTable
                try {
                    New-Variable -Name "CustomR$($RowIterator)C$($ColumnIterator)" -Value $( [System.Windows.Forms.Label]::new() ) -ErrorAction Stop
                } catch {
                    Remove-Variable -Name "CustomR$($RowIterator)C$($ColumnIterator)" -Force
                    New-Variable -Name "CustomR$($RowIterator)C$($ColumnIterator)" -Value $( [System.Windows.Forms.Label]::new() )
                }
                $(Get-Variable -Name "CustomR$($RowIterator)C$($ColumnIterator)" -ValueOnly).Name = "CustomR$($RowIterator)C$($ColumnIterator)"
                $(Get-Variable -Name "CustomR$($RowIterator)C$($ColumnIterator)" -ValueOnly).Size = [System.Drawing.Size]::new( $Width, $Height )
                $(Get-Variable -Name "CustomR$($RowIterator)C$($ColumnIterator)" -ValueOnly).Padding = [System.Windows.Forms.Padding]::new( $Left, $Top, $Right, $Bottom )
                $(Get-Variable -Name "CustomR$($RowIterator)C$($ColumnIterator)" -ValueOnly).Margin = [System.Windows.Forms.Padding]::new( $Left, $Top, $Right, $Bottom )
                $(Get-Variable -Name "CustomR$($RowIterator)C$($ColumnIterator)" -ValueOnly).Text = " "
                $(Get-Variable -Name "CustomR$($RowIterator)C$($ColumnIterator)" -ValueOnly).TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
                $(Get-Variable -Name "CustomR$($RowIterator)C$($ColumnIterator)" -ValueOnly).Font = [System.Drawing.Font]::new( "Verdana", 12 )
                $(Get-Variable -Name "CustomR$($RowIterator)C$($ColumnIterator)" -ValueOnly).BackColor = [System.Drawing.Color]::White
                $(Get-Variable -Name "CustomR$($RowIterator)C$($ColumnIterator)" -ValueOnly).ForeColor = [System.Drawing.Color]::Black
                $(Get-Variable -Name "CustomR$($RowIterator)C$($ColumnIterator)" -ValueOnly).Add_Click({
                    $this.Focus()
                })
                $(Get-Variable -Name "CustomR$($RowIterator)C$($ColumnIterator)" -ValueOnly).Add_KeyDown({
                    $CurrentSudokuRow = ($this.Name -replace '[^1-9]','').Substring(0,1)
                    $CurrentSudokuColumn = ($this.Name -replace '[^1-9]','').Substring(1,1)
                    if ((( $_.KeyCode -replace '[^1-9]','' ) -match '[1-9]' ) -and (( $this.Text -notmatch '[1-9]' ) -or ( $this.ForeColor -eq [System.Drawing.Color]::Blue ))) {
                        $CurrentSudokuGrid = ConvertTo-SudokuGrid -SudokuTable $CustomSudokuTable
                        if ( IsMoveValid -SudokuGrid $CurrentSudokuGrid -Row $CurrentSudokuRow -Column $CurrentSudokuColumn -Number $($_.KeyCode -replace '[^1-9]') ) {
                            $this.Text = $_.KeyCode -replace '[^1-9]',''
                            $this.ForeColor = [System.Drawing.Color]::Blue
                            if ($CurrentSudokuColumn -le 8) {
                                $NextSudokuRow = [int32]$CurrentSudokuRow
                                $NextSudokuColumn = [int32]$CurrentSudokuColumn + 1
                            } elseif ($CurrentSudokuRow -le 8) {
                                $NextSudokuRow = [int32]$CurrentSudokuRow + 1
                                $NextSudokuColumn = 1
                            } else {
                                $NextSudokuRow = 1
                                $NextSudokuColumn = 1
                            }
                            $(Get-Variable -Name "CustomR$($NextSudokuRow)C$($NextSudokuColumn)" -ValueOnly).Focus()
                        }
                    } elseif ($_.KeyCode -eq "Back") {
                        $this.Text = ""
                        $this.ForeColor -eq [System.Drawing.Color]::Black
                        if ($CurrentSudokuColumn -ge 2) {
                            $NextSudokuRow = [int32]$CurrentSudokuRow
                            $NextSudokuColumn = [int32]$CurrentSudokuColumn - 1
                        } elseif ($CurrentSudokuRow -ge 2) {
                            $NextSudokuRow = [int32]$CurrentSudokuRow - 1
                            $NextSudokuColumn = 9
                        } else {
                            $NextSudokuRow = 9
                            $NextSudokuColumn = 9
                        }
                        $(Get-Variable -Name "CustomR$($NextSudokuRow)C$($NextSudokuColumn)" -ValueOnly).Focus()
                    }
                })
                $(Get-Variable -Name "CustomR$($RowIterator)C$($ColumnIterator)" -ValueOnly).Add_GotFocus({
                    $this.BackColor = [System.Drawing.Color]::LightGray
                })
                $(Get-Variable -Name "CustomR$($RowIterator)C$($ColumnIterator)" -ValueOnly).Add_LostFocus({
                    $this.BackColor = [System.Drawing.Color]::White
                })

                $null = $CustomSudokuTable.Controls.Add($(Get-Variable -Name "CustomR$($RowIterator)C$($ColumnIterator)" -ValueOnly))

                $ColumnIterator += 1
            }
            $RowIterator += 1
        }
        return $null
    }

    end {
        $Form.Size = [System.Drawing.Size]::new(($SudokuTable.Width + $ButtonTable.Width) * 1.2, $SudokuTable.Height * 1.2)
        $null = $Form.ShowDialog()
    }
}