[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '', Justification='PSScriptAnalyzer cannot see Pester BeforeAll scoping')]
param()

BeforeAll{
    $currentPath  = $(get-location).path
    $sourcePath   = join-path -path $currentPath -childPath 'source'
    $mockPsScriptRoot = $sourcePath

    . $PSCommandPath.Replace('.Tests.ps1','.ps1')
}

AfterAll{
    Remove-Variable mockPsScriptRoot -ErrorAction Ignore
}

Describe "Get-WelcomeMessage" {

    Context "Resource file access" {
        BeforeAll {
            $result = Get-WelcomeMessage
        }

        It "Returns a non-empty result" {
            $result | Should -Not -BeNullOrEmpty
        }

        It "Returns a string" {
            $result | Should -BeOfType [string]
        }

        It "Output contains the welcome heading" {
            $result | Should -Match "Galactic Reception Centre"
        }
    }

    Context "Missing resource file" {
        It "Throws when the resource file cannot be found" {
            $mockPsScriptRoot = (Get-Item $TestDrive).FullName
            { Get-WelcomeMessage } | Should -Throw
        }
    }

}
