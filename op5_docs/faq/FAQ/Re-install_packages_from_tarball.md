# Re-install packages from tarball

## How do I re-install packages from an install-tarball?

* * * * *

 

You can use the unpacked tarball directory as a repo with the config file created when you ran install.sh the first time.
Go to the install directory:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# cd /path/to/op5-monitor-6.2.1
```

Verify that you have a file called op5-yum.conf:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# ls -l op5-yum.conf
```

Then, when you are standing in that directory, run the following, all on one line:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# yum -c op5-yum.conf --disablerepo=*op5* --enablerepo=*install* reinstall @op5-monitor
```

 

 

 

