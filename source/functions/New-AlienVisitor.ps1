function New-AlienVisitor {
    param (
        [string]$Name,
        [string]$HomePlanet,
        [ValidateAlienFoodAttribute()]
        [string]$FavoriteFood
    )

    $alien = [AlienVisitor]::new($Name, $HomePlanet, $FavoriteFood)
    return $alien
}
