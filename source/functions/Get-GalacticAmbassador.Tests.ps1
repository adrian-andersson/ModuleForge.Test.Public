BeforeAll{
    #Reference Current Path
    $currentPath = $(get-location).path
    $sourcePath = join-path -path $currentPath -childPath 'source'
    #Reference Dependencies
    $dependencies = [ordered]@{
        validationClasses = @('ValidateAlienFoodAttribute.ps1')
        classes = @('AlienVisitor.ps1','GalacticAmbassador.ps1')
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


Describe "Get-GalacticAmbassador" {

    It "Returns a non-empty result" {
        Get-GalacticAmbassador | Should -Not -BeNullOrEmpty
    }

    It "Uses the default values when no parameters are supplied" {
        Get-GalacticAmbassador | Should -Match "I am Zarnak from planet Nebula-7"
        Get-GalacticAmbassador | Should -Match "the esteemed title of Celestial Diplomat"
    }

    It "Honours supplied parameter values" {
        $result = Get-GalacticAmbassador -Name "Glorp" -HomePlanet "Vega-3" -FavoriteFood "tacos" -Title "Supreme Envoy"
        $result | Should -Match "I am Glorp from planet Vega-3"
        $result | Should -Match "My favorite food here is tacos"
        $result | Should -Match "the esteemed title of Supreme Envoy"
    }

}
