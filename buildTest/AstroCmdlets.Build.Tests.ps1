[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '', Justification='PSScriptAnalyzer cannot see Pester BeforeAll scoping')]
param()

#
# buildTest — Compiled-module functional suite
# --------------------------------------------
# Unlike the source/**/*.Tests.ps1 files (which dot-source individual .ps1 files
# pre-build), this suite treats the COMPILED, INSTALLED module as a black box:
# it imports the module by name and exercises every exported command, the alias,
# the validation class, the enum, and the bundled resource file.
#
# Because the module is properly installed alongside its resource/ folder, this is
# where Get-WelcomeMessage's production $PSScriptRoot path is exercised for real -
# the path the $mockPsScriptRoot source test deliberately cannot cover.
#

BeforeAll {
    # moduleForgeConfig.xml lives at the repo root (the parent of this buildTest folder)
    $repoRoot   = Split-Path -Parent $PSScriptRoot
    $configPath = Join-Path $repoRoot 'moduleForgeConfig.xml'
    if(-not (Test-Path $configPath)){
        throw "buildTest: unable to find moduleForgeConfig.xml at: $configPath"
    }
    $moduleName = (Import-Clixml $configPath).moduleName
    Write-Verbose "buildTest target module: $moduleName"

    # Import the installed/compiled module as a black box. No dot-sourcing of source files.
    Import-Module $moduleName -Force -ErrorAction Stop
    $module = Get-Module $moduleName
    if(-not $module){
        throw "buildTest: module '$moduleName' did not load"
    }
}

AfterAll {
    Remove-Module $moduleName -Force -ErrorAction Ignore
}

Describe "Compiled module" {

    Context "Module load" {
        It "Is loaded into the session" {
            $module | Should -Not -BeNullOrEmpty
        }
    }

    Context "Exported commands" {
        It "Exports <_>" -ForEach @(
            'Get-GalacticAmbassador'
            'Get-GalacticReception'
            'Get-WelcomeMessage'
            'New-AlienVisitor'
            'Start-Blastoff'
        ) {
            $module.ExportedCommands.Keys | Should -Contain $_
        }

        It "Does not export the private helper Get-AlienVisitorWelcome" {
            $module.ExportedCommands.Keys | Should -Not -Contain 'Get-AlienVisitorWelcome'
        }
    }

    Context "Exported alias" {
        It "Exports the blastOff alias targeting Start-Blastoff" {
            $alias = $module.ExportedAliases['blastOff']
            $alias            | Should -Not -BeNullOrEmpty
            $alias.Definition | Should -Be 'Start-Blastoff'
        }
    }

    Context "Functions and classes" {
        It "New-AlienVisitor returns an AlienVisitor object" {
            $alien = New-AlienVisitor -Name 'Zog' -HomePlanet 'Xenon-9' -FavoriteFood 'Quantum Quinoa'
            $alien                 | Should -Not -BeNullOrEmpty
            $alien.GetType().Name  | Should -Be 'AlienVisitor'
            $alien.Name            | Should -BeExactly 'Zog'
            $alien.HomePlanet      | Should -BeExactly 'Xenon-9'
            $alien.FavoriteFood    | Should -BeExactly 'Quantum Quinoa'
        }

        It "Get-GalacticAmbassador returns the inherited-class introduction" {
            $intro = Get-GalacticAmbassador
            $intro | Should -Match 'I am Zarnak from planet Nebula-7'
            $intro | Should -Match 'the esteemed title of Celestial Diplomat'
        }

        It "Get-GalacticReception welcomes a default visitor" {
            Get-GalacticReception | Should -Match 'Greetings, Earthlings!'
        }
    }

    Context "Validation class" {
        It "New-AlienVisitor accepts an approved food" {
            { New-AlienVisitor -Name 'Good' -HomePlanet 'Somewhere' -FavoriteFood 'tacos' } | Should -Not -Throw
        }
        It "New-AlienVisitor rejects an unapproved food" {
            { New-AlienVisitor -Name 'Bad' -HomePlanet 'Nowhere' -FavoriteFood 'cardboard' } | Should -Throw
        }
    }

    Context "Enum" {
        It "Start-Blastoff accepts a valid SpaceSuitType value" {
            Start-Blastoff -RocketName 'Voyager' -AstronautSuit 'Lunar' |
                Should -Contain "Astronauts are suiting up in their Lunar spacesuits."
        }
        It "Start-Blastoff rejects an invalid SpaceSuitType value" {
            { Start-Blastoff -RocketName 'Voyager' -AstronautSuit 'Bogus' } | Should -Throw
        }
    }

    Context 'Resource access (production $PSScriptRoot path)' {
        It "Get-WelcomeMessage reads the bundled resource file" {
            $msg = Get-WelcomeMessage
            $msg | Should -Not -BeNullOrEmpty
            $msg | Should -Match 'Galactic Reception Centre'
        }
    }
}
