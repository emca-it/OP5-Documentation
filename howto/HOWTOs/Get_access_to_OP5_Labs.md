# Get access to OP5 Labs

Version

This article was written for version 7.3.14 of OP5 Monitor, it could work on both lower and higher version if nothing else is stated.

Articles in the Community-Space are not supported by OP5 Support.

# What is OP5 Labs?

OP5 Labs is a yum repository where we can give you as a customer early access to experimental packages that we want early feedback on.
Since the yum repository is **disabled by default**, you need to add \`--enablerepo\` flag **every time** you want to use it.

# How do I get it?

First you need to install the OP5 Labs repository

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
yum install -y op5-release-labs
```

Then you can **search** for packages in OP5 Labs

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
yum --enablerepo='op5-monitor-labs-updates' search <package-name/keyword>
```

And **install** packages from OP5 Labs

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
yum --enablerepo='op5-monitor-labs-updates' install <package-name>
```

Or **upgrade** packages installed from OP5 Labs

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
yum --enablerepo='op5-monitor-labs-updates' upgrade <package-name>
```
