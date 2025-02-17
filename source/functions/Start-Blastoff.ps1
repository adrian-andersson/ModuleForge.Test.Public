function Start-Blastoff {
    param (
        [string]$RocketName,
        [SpaceSuitType]$AstronautSuit
    )

    "Countdown initiated for rocket '$RocketName'..."
    "Astronauts are suiting up in their $AstronautSuit spacesuits."
    #Start-Sleep -Seconds 3
    3..1 | ForEach-Object {
        "T-minus $_ seconds..."
        Start-Sleep -milliseconds 200
    }
    "🚀 Launch successful! '$RocketName' has reached orbit!"
}

Set-Alias -Name blastOff -Value Start-Blastoff
