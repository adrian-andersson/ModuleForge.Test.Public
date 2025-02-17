BeforeAll{
    #Reference Current Path
    $currentPath = $(get-location).path
    $sourcePath = join-path -path $currentPath -childPath 'source'
    #Reference Dependencies
    $dependencies = [ordered]@{
        enums = @('SpaceSuitType.ps1')
        validationClasses = @('ValidateAlienFoodAttribute.ps1')
        classes = @('AlienVisitor.ps1','GalacticAmbassador.ps1')
        private = @('Get-AlienVisitorWelcome.ps1')
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

Describe "New-AlienVisitor" {
    BeforeAll {
        $alien = New-AlienVisitor -Name "Zog" -HomePlanet "Xenon-9" -FavoriteFood "Quantum Quinoa"
        #write-verbose "$($alien.getType()|out-string)"
    }
            
    It "Is able to create an alien from New-AlienVisitor" {
        $alien |Should -Not -BeNullOrEmpty
    }
    
    It "Alien Object is of the correct type" {
        $alien.getType().name | Should -Be 'AlienVisitor'
    }

    It "Alien Object should have the correct values" {
        $alien.Name | Should -BeExactly "Zog"
        $alien.HomePlanet | Should -BeExactly "Xenon-9"
        $alien.FavoriteFood | Should -BeExactly "Quantum Quinoa"
    }
        
}

