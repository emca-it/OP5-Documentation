# Execute PowerShell scripts

Version

This article was written for version 7.0 of Monitor, it could work on both lower and higher version if nothing else is stated.

Articles in the Community-Space are not supported by op5 Support.

# Introduction

This how-to will show you how to execute a powershell script via the op5 Agent.

# Prerequisites

-   Working installation of op5 Agent 
-   Working installation of op5 Monitor

# Create powerShell script

First we need to create a powershell script or use an existing one. In this example we will use a simple Hello World script.

The script that we will use is

**hello.ps1**

``` {.powershell data-syntaxhighlighter-params="brush: powershell; gutter: true; theme: Confluence" data-theme="Confluence" style="brush: powershell; gutter: true; theme: Confluence"}
 Write-Host "Hello World! `n" 
```

This will be placed in the script folder within the agent installation folder, in this case in: C:\\Program Files\\op5\\NSClient++\\scripts\\

Save the script as hello.ps1

# Add the script to op5 Agent

To make the op5 Agent aware of the script and how it should be executed we need to add a handler for it in the agent configuration.

Open the file custom.ini located in C:\\Program Files\\op5\\NSClient++\\ and add the following rows

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
[NRPE Handlers]
hello=cmd /c echo scripts\hello.ps1; exit $LastExitCode | powershell.exe -noprofile -nologo -command -
```

# Set ExecutionPolicy

Due to restrictions in powershell we are not allowed to run this file without changing the execution policy for powershell scripts.

In this example we will change the policy to unrestricted but this is not recommended for normal use. For more information about Execution Policy see <http://technet.microsoft.com/library/hh847748.aspx>.

Open powershell prompt as administrator and run

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
PS C:\Windows\system32> Set-ExecutionPolicy unrestricted
```

Answer Y on the question.

![](attachments/12190637/12386438.png)

# Run script from op5 Monitor console

This step is not necessary, but can be good before continuing just to make sure everything is working before change the configuration.

Log in to op5 Monitor via console or SSH.

Run the following command to test the powershell script

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# /opt/plugins/check_nrpe -H 192.168.1.198 -c hello
```

If everything is working you should get the response "Hello World!"

# Adding script to a host

Go to the configuration of a host in op5 Monitor and add a new service.

1.  Enter a Service Description of you choice
2.  Select *check\_nrpe* as check\_command 
3.  Enter *hello* as check\_command\_args
    ![](attachments/12190637/12386439.png)
4.  Save the configuration.

