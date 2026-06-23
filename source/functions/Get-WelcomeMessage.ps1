function Get-WelcomeMessage
{

    <#
        .SYNOPSIS
            Returns the welcome message for the Galactic Reception Centre.

        .DESCRIPTION
            Reads the welcome message from the bundled text.txt resource file and returns
            it as a string. Demonstrates how module resource files are accessed via
            $PSScriptRoot, which resolves to the module directory in the compiled module
            and must be overridden with $mockPsScriptRoot when testing pre-build.

        ------------
        .EXAMPLE
            Get-WelcomeMessage

            #### DESCRIPTION
            Returns the welcome message bundled with the module.

            #### OUTPUT
            Welcome to the Galactic Reception Centre!
            All visitors must declare a favourite food from the approved list.
            Unauthorised food preferences will result in immediate deportation.

        .NOTES
            Author: Adrian.Andersson

    #>

    [CmdletBinding()]
    [OutputType([string])]
    PARAM()
    begin{
        write-verbose "===========Executing $($MyInvocation.InvocationName)==========="
        Write-Debug "BoundParams: $($MyInvocation.BoundParameters|Out-String)"

        if($mockPsScriptRoot)
        {
            Write-Warning 'Using $mockPsScriptRoot for resource path. This should only be done for testing.'
            $resourceFolder = Join-Path $mockPsScriptRoot 'resource'
        }
        else
        {
            $resourceFolder = Join-Path $PSScriptRoot 'resource'
        }

        $resourceFile = Join-Path $resourceFolder 'text.txt'

        if(-not (Test-Path $resourceFile))
        {
            throw "Get-WelcomeMessage: unable to find resource file at: $resourceFile"
        }
    }

    process{
        Write-Verbose "Reading welcome message from: $resourceFile"
        Get-Content $resourceFile -Raw
    }

}
