#It keyword is more in depth description of the test
#Describe is the name of the test case
#BeforeAll is used to run code prior to all the test cases
Describe 'AddTwoNumbers' {
    BeforeAll {
        . ("$($PSScriptRoot)" + "\..\..\Public\HelloWorld.ps1")
    }
    It '2 + 2 = 4' {
        [int32]$CorrectAnswer = 4
        (AddTwoNumbers -x 2 -y 2) | Should be $CorrectAnswer
    }
}