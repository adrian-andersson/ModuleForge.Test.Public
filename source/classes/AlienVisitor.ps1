class AlienVisitor {
    [string]$Name
    [string]$HomePlanet

    [ValidateAlienFoodAttribute()]
    [string]$FavoriteFood

    <#
    AlienVisitor()
    {
        $objType = $this.GetType()
        if($objType -eq [AlienVisitor])
        {
            Throw "Parent Class $($objType.Name) Must Be Inherited"
        }
    }
    #>


    AlienVisitor([string]$Name, [string]$HomePlanet, [string]$FavoriteFood) {
        $this.Name = $Name
        $this.HomePlanet = $HomePlanet
        $this.FavoriteFood = $FavoriteFood
    }

    [string] GetIntroduction() {
        return "Greetings, Earthlings! I am $($this.Name) from planet $($this.HomePlanet). My favorite food here is $($this.FavoriteFood)."
    }

    hidden [string] GetReflectedIntroduction([AlienVisitor]$Ref) {
        return "Greetings, Earthlings! I am $($Ref.Name) from planet $($Ref.HomePlanet). My favorite food here is $($Ref.FavoriteFood)."
    }
}
