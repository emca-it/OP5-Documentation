# Adding license

This article describes how to add you license manually. Requires you have received a license from OP5.

## Step-by-step guide

1.  Copy your license to your OP5 Monitor server using scp client (e.g. winscp)
2.  As root user on your OP5 Monitor server copy the license to /etc/op5license and name it op5license.lic

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    cp path_to_your_license /etc/op5license/op5license.lic
    ```

3.  Set ownership and permissions

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    chmod 640 /etc/op5license/op5license.lic
    chown apache:apache /etc/op5license/op5license.lic
    ```

4.  Verify

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    asmonitor /opt/plugins/check_op5_license -T d -w 30 -c 15
    ```


