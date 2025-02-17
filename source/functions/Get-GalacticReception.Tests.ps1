BeforeAll{
#Reference Current Path
    $currentPath = $(get-location).path
    $sourcePath = join-path -path $currentPath -childPath 'source'

    $dependencies = [Ordered]@{
        validationClasses = @('ValidateAlienFoodAttribute.ps1')
        enums = @('SpaceSuitType.ps1')
        classes = @('AlienVisitor.ps1','GalacticAmbassador.ps1')
        private = @('Get-AlienVisitorWelcome.ps1')
        functions = @('New-AlienVisitor.ps1')
    }

    $dependencies.GetEnumerator().ForEach{
        $DirectoryRef = join-path -path $sourcePath -childPath $_.Key
        $_.Value.ForEach{
            $ItemPath = join-path -path $DirectoryRef -childpath $_
            $ItemRef = get-item $ItemPath -ErrorAction SilentlyContinue
            if($ItemRef){
                write-verbose "Dependency identified at: $($ItemRef.fullname)"
                . $ItemRef.Fullname
            }else{
                write-warning "Dependency not found at: $ItemPath"
            }
        }
    }
    
    #Load THis File
    . $PSCommandPath.Replace('.Tests.ps1','.ps1')


}

    

Describe "Get-GalacticReception" {
    BeforeAll {
        $existingAlien = New-AlienVisitor -Name "Grok" -HomePlanet "Nebula-7" -FavoriteFood "Stellar Sushi"
    }
    It "Is able to create an alien from New-AlienVisitor" {
        $existingAlien |Should -Not -BeNullOrEmpty
    }
    It "Alien Object is of the correct type" {
        $existingAlien.getType().name | Should -Be 'AlienVisitor'
    }
    It "Welcomes an existing AlienVisitor" { 
        Get-GalacticReception -Visitor $existingAlien | Should -Contain "Greetings, Earthlings! I am Grok from planet Nebula-7. My favorite food here is Stellar Sushi."
    }

    It "Welcomes a default AlienVisitor" {
        Get-GalacticReception | Should -Contain "Greetings, Earthlings! I am Zog from planet Xenon-9. My favorite food here is Quantum Quinoa."
    }
}



