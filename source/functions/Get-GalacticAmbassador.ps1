function Get-GalacticAmbassador {
    param (
        [string]$Name = "Zarnak",
        [string]$HomePlanet = "Nebula-7",
        [string]$FavoriteFood = "Quantum Quinoa",
        [string]$Title = "Celestial Diplomat"
    )

    $ambassador = [GalacticAmbassador]::new($Name, $HomePlanet, $FavoriteFood, $Title)
    $ambassador.GetIntroduction()
}
