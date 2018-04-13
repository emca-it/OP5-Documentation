# How do I use ssh: links from my Windows Browser?

## Question

* * * * *

How do I use ssh: links from my Windows Browser?

## Answer

* * * * *

First you'll need to teach Windows about the SSH protocol. Create file called ssh.reg with this content:

``` {.plain data-syntaxhighlighter-params="brush: plain; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: plain; gutter: false; theme: Confluence"}
REGEDIT4

[HKEY_CLASSES_ROOT\ssh]

@="URL:ssh Protocol"

"URL Protocol"=""

[HKEY_CLASSES_ROOT\ssh\shell]

[HKEY_CLASSES_ROOT\ssh\shell\open]

[HKEY_CLASSES_ROOT\ssh\shell\open\command]

@="\"C:\\Program Files\\putty\\putty.exe\" \"%1\""
```

Run this file to add the information to the Windows Registry. You probably need to reboot for this to take effect.

For Firefox you'll need to enter this in **about:config**

``` {.plain data-syntaxhighlighter-params="brush: plain; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: plain; gutter: false; theme: Confluence"}
network.protocol-handler.app.ssh  STRING "C:\Program Files\Putty"

network.protocol-handler.external.ssh  BOOL   true

network.protocol-handler.expose.ssh  BOOL   true

network.protocol-handler.warn-external.ssh BOOL   false
```
