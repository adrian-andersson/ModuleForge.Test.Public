function Get-GalacticReception {
    param (
        [AlienVisitor]$Visitor = $null
    )

    if (-not $Visitor) {
        # Summon a default alien visitor
        $Visitor = New-AlienVisitor -Name "Zog" -HomePlanet "Xenon-9" -FavoriteFood "Quantum Quinoa"
    }

    # Welcome the visitor
    Get-AlienVisitorWelcome -Visitor $Visitor
}
