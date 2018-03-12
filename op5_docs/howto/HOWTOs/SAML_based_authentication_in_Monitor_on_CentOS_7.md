# SAML based authentication in Monitor on CentOS 7

Version

This article was written for version 7.3.18 of OP5 Monitor on EL7, it could work on both lower and higher version if nothing else is stated.

Articles in the Community-Space are not supported by OP5 Support.

This article describes how to add SAML based SSO authentication to OP5 Monitor using Apache auth adapter and mod\_auth\_mellon. The Identity Provider (IdP) used in this example is Okta. 

## Step-by-step guide

Create Okta Account:

1.  Go to <https://www.okta.com/start-with-okta/> and create a free developer account. You should get an email containing details of your account including the associated subdomain e.g. [https://dev-xxxxxx.oktapreview.com](https://dev-292660.oktapreview.com/)
2.  Login to your [https://dev-xxxxxx.oktapreview.com](https://dev-292660.oktapreview.com/) and switch to Admin view.
3.  Follow this [guide](https://developer.okta.com/standards/SAML/setting_up_a_saml_application_in_okta) to set up a SAML application in Okta, and make sure you replace the following parameters:
    1.  Single Sign On URL = https:///mellon/postResponse
    2.  Audience URI (SP Entity ID) = https:///mellon/metadata

4.  Save the downloaded metadata file somewhere safe. You will need it later.

Configure authentication adapter in Monitor

1.  Create Apache auth driver in Manage/Configure/Authentication Modules.
2.  Select the created apache driver in the Common tab and enable auto login.
3.  Create **apache\_auth\_user** group in Manage/Configure/Group Rights with the same permission as the existing **admins** group.

Configure mod\_auth\_mellon module to Apache in Monitor:

1.  SSH to your Monitor machine.
2.  Install mod\_auth\_mellon: 

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    yum install mod_auth_mellon
    ```

    This will install mod\_auth\_mellon v0.11. We will need to update it to the latest version, which is possible by building the module from source. Keep in mind,  it will require a lot of development packages, so maybe you want to compile it on a separate machine and simply overwrite the generated \*.so file.

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    yum groupinstall "Development Tools"
    yum install lasso lasso-devel httpd-devel libcurl-devel
    git clone https://github.com/UNINETT/mod_auth_mellon
    cd mod_auth_mellon
    git checkout tags/v0.13.1
    git checkout -b v0.13.1
    ./autogen.sh
    ./configure --with-apxs2=/usr/bin/apxs
    make && make install
    ```

    This should overwrite the previously installed module, but keep all the config files intact.

3.  Create a folder that will store mellon configuration and execute a mellon script:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    mkdir /etc/httpd/mellon
    cd /etc/httpd/mellon
    # assuming that location of the cloned repository is /root/mod_auth_mellon
    /root/mod_auth_mellon/mellon_create_metadata.sh op5_okta_<random_id> https://<monitor_ip>/mellon
    ```

4.  Copy the downloaded from Okta metadata file to /etc/httpd/mellon
5.  Change ownership of the files:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    chown monitor:apache /etc/httpd/mellon/*
    ```

6.  Edit the /etc/httpd/conf.d/auth\_mellon.conf file and add the following configuration:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    MellonCacheSize 100
    MellonLockFile "/run/mod_auth_mellon/lock"

    <Location />
        #Require valid-user
        AuthType "Mellon"
        MellonEnable "info"
        MellonVariable "cookie2"
        #MellonSecureCookie On
        MellonCookiePath /
        MellonUser "NAME_ID"
        MellonSessionDump Off
        MellonSamlResponseDump Off
        MellonEndpointPath "/mellon"
        MellonDefaultLoginPath "/"
        MellonSessionLength 43200
        MellonSPPrivateKeyFile /etc/httpd/mellon/op5_okta.key
        MellonSPCertFile /etc/httpd/mellon/op5_okta.cert
        MellonIdPMetadataFile /etc/httpd/mellon/metadata
        MellonRedirectDomains [self] dev-xxxxx.oktapreview.com
        RequestHeader set PHP_AUTH_USER %{MELLON_NAME_ID}e
        ProxyPassInterpolateEnv On
    </Location>
    <Location /monitor/>
        MellonEnable "auth"
    </Location>
    ```

    Make sure you set correct values for MellonSPPrivateKeyFile, MellonSPCertFile and MellonRedirectDomains.

7.  Restart apache:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    systemctl restart httpd
    ```

8.  Navigate to https://\<monitor\_ip\>/monitor. You should be redirected to the Okta login page.

## Resources

<https://stackoverflow.com/questions/32709589/mod-auth-mellon-not-populating-environment-variables>

<https://stackoverflow.com/questions/42438405/mod-auth-mellon-environment-variables-are-null?noredirect=1&lq=1>

<https://github.com/UNINETT/mod_auth_mellon>

<https://developer.okta.com/standards/SAML/setting_up_a_saml_application_in_okta>

<https://github.com/UNINETT/mod_auth_mellon/wiki/GenericSetup>

<https://serverfault.com/questions/739756/splunk-saml-sso-from-an-idp-with-apache-mod-mellon-fails>

<https://support.okta.com/help/answers?id=9062A000000bmU9QAI>

<https://centos.pkgs.org/7/centos-x86_64/mod_auth_mellon-0.11.0-4.el7.x86_64.rpm.html>

<https://www.cvedetails.com/vulnerability-list/vendor_id-12496/product_id-30324/Uninett-Mod-Auth-Mellon.html>

## Related articles

-   Page:
    [Alerting and troubleshooting in general](/display/SUPPORT/Alerting+and+troubleshooting+in+general)
-   Page:
    [Generate xml license files](/display/SUPPORT/Generate+xml+license+files)
-   Page:
    [Troubleshooting high memory usage](/display/SUPPORT/Troubleshooting+high+memory+usage)
-   Page:
    [Prettify XML in VIM](/display/SUPPORT/Prettify+XML+in+VIM)
-   Page:
    [Pinpoint host and service execution time](/display/SUPPORT/Pinpoint+host+and+service+execution+time)


