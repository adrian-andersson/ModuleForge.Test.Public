class ValidateAlienFoodAttribute : System.Management.Automation.ValidateArgumentsAttribute
{
    [void] Validate([object]$arguments,[System.Management.Automation.EngineIntrinsics]$engineIntrinsics)
    {
        $alienFood = $arguments -as [string]
        if ($alienFood -notin @('pizza','chocolate','tacos','Quantum Quinoa','Stellar Sushi')) {
            throw [System.Management.Automation.ValidationMetadataException] "Invalid alien food preference. Must be pizza, chocolate, tacos, Quantum Quinoa, or Stellar Sushi."
        }
    }
}
