class GalacticAmbassador : AlienVisitor {
    [string]$Title

    <#
    GalacticAmbassador([string]$Name, [string]$HomePlanet, [string]$FavoriteFood, [string]$Title) {
        # Call the base constructor (AlienVisitor)
        #parent::AlienVisitor($Name, $HomePlanet, $FavoriteFood)
        #$this.Title = $Title
        base($Name, $HomePlanet, $FavoriteFood)
        #$this.Name = $Name
        #$this.HomePlanet = $HomePlanet
        #$this.FavoriteFood = $FavoriteFood
    }
    #>
    GalacticAmbassador([string]$Name, [string]$HomePlanet, [string]$FavoriteFood, [string]$Title) : base([string]$Name, [string]$HomePlanet, [string]$FavoriteFood) {
        # Call the base constructor (AlienVisitor)
        #parent::AlienVisitor($Name, $HomePlanet, $FavoriteFood)
        $this.Title = $Title
        #base($Name, $HomePlanet, $FavoriteFood)
        #$this.Name = $Name
        #$this.HomePlanet = $HomePlanet
        #$this.FavoriteFood = $FavoriteFood
    }
    

    [string] GetIntroduction() {
        #$baseIntro = parent::GetIntroduction()
        #$baseIntro = base::GetIntroduction()
        #$BaseIntro = GalacticAmbassador:base
        #$BaseIntro = [AlienVisitor].GetMethod('GetReflectedIntroduction').Invoke($this)
        $BaseIntro = "Greetings, Earthlings! I am $($this.Name) from planet $($this.HomePlanet). My favorite food here is $($this.FavoriteFood).`n"
        
        return "$baseIntro I am the Galactic Ambassador, holding the esteemed title of $($this.Title)."
    }
}
