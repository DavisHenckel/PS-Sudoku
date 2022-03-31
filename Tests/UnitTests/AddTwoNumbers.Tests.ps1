Describe 'AddTwoNumbers' {
    It '2 + 2 = 4' {
        [int32]$CorrectAnswer = 4
        (AddTwoNumbers -x 2 -y 2) | Should be $CorrectAnswer
    }
}