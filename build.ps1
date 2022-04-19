param (
    [ValidateSet("Release", "debug")]$Configuration = "debug",
    [Parameter(Mandatory=$false)][String]$NugetAPIKey,
    [Parameter(Mandatory=$false)][Switch]$ExportAlias
)

function Init {
    Write-Verbose -Message "Initializing Module PSScriptAnalyzer"
    if (-not(Get-Module -Name PSScriptAnalyzer -ListAvailable)){
        Write-Warning "Module 'PSScriptAnalyzer' is missing or out of date. Installing module now."
        Install-Module -Name PSScriptAnalyzer -Scope CurrentUser -Force
    }

    Write-Verbose -Message "Initializing Module Pester"
    if (-not(Get-Module -Name Pester -ListAvailable)){
        Write-Warning "Module 'Pester' is missing or out of date. Installing module now."
        Install-Module -Name Pester -Scope CurrentUser -Force
    }

    Write-Verbose -Message "Initializing PowerShellGet"
    if (-not(Get-Module -Name PowerShellGet -ListAvailable)){
        Write-Warning "Module 'PowerShellGet' is missing or out of date. Installing module now."
        Install-Module -Name PowerShellGet -Scope CurrentUser -Force
    }

    Write-Verbose -Message "Initializing platyPS"
    if (-not(Get-Module -Name platyPS -ListAvailable)){
        Write-Warning "Module 'platyPS' is missing or out of date. Installing module now."
        Install-Module -Name platyPS -Scope CurrentUser -Force
    }
    Write-Verbose -Message "Initializing PowerShell-CICD"
    if (-not(Get-Module -Name PowerShell-CICD -ListAvailable)){
        Write-Warning "Module 'PowerShell-CICD' is missing or out of date. Installing module now."
        .\LocalModuleInstall.ps1
    }
}

function Test {
    try {
        Write-Verbose -Message "Running PSScriptAnalyzer on Public functions"
        Invoke-ScriptAnalyzer ".\Public" -Recurse
        Write-Verbose -Message "Running PSScriptAnalyzer on Private functions"
        Invoke-ScriptAnalyzer ".\Private" -Recurse
    }
    catch {
        Write-Error $_
        throw "Couldn't run Script Analyzer"
    }

    Write-Verbose -Message "Running Pester Unit Tests"
    $Results = Invoke-Pester -Script ".\Tests\UnitTests\*.ps1" -OutputFormat NUnitXml -OutputFile ".\Tests\UnitTests\UnitTestsResults.xml"
    if($Results.FailedCount -gt 0){
        throw "$($Results.FailedCount) Tests failed"
    }

    Write-Verbose -Message "Running Pester Integration Tests"
    $Results = Invoke-Pester -Script ".\Tests\IntegrationTests\*.ps1" -OutputFormat NUnitXml -OutputFile ".\Tests\IntegrationTestsResults.xml"
    if($Results.FailedCount -gt 0){
        throw "$($Results.FailedCount) Tests failed"
    }

    Write-Verbose -Message "Running Pester Acceptance Tests"
    $Results = Invoke-Pester -Script ".\Tests\AcceptanceTests\*.ps1" -OutputFormat NUnitXml -OutputFile ".\Tests\AcceptanceTestsResults.xml"
    if($Results.FailedCount -gt 0){
        throw "$($Results.FailedCount) Tests failed"
    }
}

Init
Test