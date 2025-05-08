function New-AlienVisitor {
    param (
        [string]$Name,
        [string]$HomePlanet,
        [ValidateAlienFoodAttribute()]
        [string]$FavoriteFood
    )
    #Use the AlienVisitor class that we created in .classes
    $alien = [AlienVisitor]::new($Name, $HomePlanet, $FavoriteFood)
    return $alien
}
