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


Describe "Start-Blastoff" {
    
    It 'Should have the right Command Name' {
        
        (Get-Command -name 'Start-Blastoff' ) |Should -be $true
    }
    It 'Should be able to execute the command' {
        $rocketName = "Starship Voyager"
        $astronautSuit = "Lunar"
        (Start-Blastoff -RocketName $rocketName -AstronautSuit $astronautSuit).count| Should -BeGreaterThan 1
    }
    It "Displays countdown and spacesuit type" {
        $rocketName = "Starship Voyager"
        #$astronautSuit = [SpaceSuitType]::Lunar
        $astronautSuit = "Lunar"
        Start-Blastoff -RocketName $rocketName -AstronautSuit $astronautSuit | Should -Contain "Countdown initiated for rocket '$rocketName'..."
        Start-Blastoff -RocketName $rocketName -AstronautSuit $astronautSuit | Should -Contain "Astronauts are suiting up in their $astronautSuit spacesuits."
    }
    
}




