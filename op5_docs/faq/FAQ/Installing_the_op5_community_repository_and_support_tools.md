# Installing the op5 community repository and support tools

## Question

* * * * *

How do I install the op5 community yum package repository, and the "support tools" found within?

## Answer

* * * * *

#### op5 Monitor 7.0.4 or later

As of version 7.0.4 of op5 Monitor, the community repository files are pre-installed. The repositories are, however, marked as disabled and must be enabled on the command line.

 

To install the support tools, run the command below.

``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
yum --enablerepo=\* clean all; yum --enablerepo=op5-community install op5-support-modules\*
```

In case some tools are already installed, or some are not up to date, this command will install all missing tools and make sure they are all updated to the latest version.

 

#### op5 Monitor 7.0.3 or earlier

In case of running a version that is older than 7.0.4, it is recommended to simply upgrade to 7.0.4 (or later), and then execute the command above. However, if upgrading is not feasible, please find further instructions below.

 

1.  Download the rpm file containing the community repository files:

    ``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
    curl -sSvo community.rpm https://download.op5.com/community.rpm
    ```

2.  Verify and install the downloaded package file:

    ``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
     rpm -Kv community.rpm && rpm -Uvh community.rpm
    ```

    Be wary of any error messages. All lines should include the text string *OK*.

3.  Finally, install the support tools:

    ``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
     yum --enablerepo=\* clean all; yum --enablerepo=op5-community install op5-support-modules\*
    ```


