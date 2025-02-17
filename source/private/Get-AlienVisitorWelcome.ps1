function Get-AlienVisitorWelcome {
    param (
        [AlienVisitor]$Visitor
    )

    $Visitor.GetIntroduction()
}
