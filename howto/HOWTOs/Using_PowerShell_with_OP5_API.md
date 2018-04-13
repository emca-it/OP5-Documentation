# Using PowerShell with OP5 API

Version

This article was written for version 7.3.14 of OP5 Monitor or later.

Articles in the Community-Space are not supported by OP5 Support.

## Introduction

This how-to will guide you to invoke POST and GET requests to the OP5 API.

## POST request

This request will create a host over the API.

**create\_host.ps1**

``` {.powershell data-syntaxhighlighter-params="brush: powershell; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: powershell; gutter: false; theme: Confluence"}
$endpoint = "https://<url_to_op5>/api/config/host"
$username = "<op5 username>"
$password = "<op5 password>"
$host = @{
    "host_name" = "<hostname>"
    "address" = "<ip of host>"
}
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))
Invoke-RestMethod -Method Post -Uri "$endpoint" -Body (ConvertTo-Json $host) -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -ContentType "application/json"
```

## GET request

This request will retrieve all hosts monitored in OP5 over the API.

**get\_hosts.ps1**

``` {.powershell data-syntaxhighlighter-params="brush: powershell; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: powershell; gutter: false; theme: Confluence"}
$endpoint = "https://<url_to_op5>/api/config/host"
$username = "<op5 username>"
$password = "<op5 password>"
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))
Invoke-RestMethod -Method Get -Uri "$endpoint" -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}
```

Note:

The invidivual code blocks above are intended to be saved in files and then executed over powershell.
