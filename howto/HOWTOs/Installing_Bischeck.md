# Installing Bischeck

This guide will help you install Bishcheck for OP5 Monitor.

To be able to use bischeck and the benifits of dynamic thresholds bischeck must first be installed and NSCA needs to be configured.
This guide requires basic linux skills.

**DISCLAMER**:
This is an unsupported plugin. More information about the bischeck plugin can be found at the [bischeck github page](https://github.com/thenodon/bischeck) or at the [bischeck.org](http://www.bischeck.org/).

# Install bischeck on OP5 Monitor

1.  Install the bischeck package:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    yum install bischeck
    ```

2.  Make sure you have your hostname added to /etc/hosts. Bischeckd will not start without this.
3.  Set permissions and ownership on the bischeck folder:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    chmod 744 -R /opt/monitor/op5/bischeck ; chown monitor:root -R /opt/monitor/op5/bischeck
    ```

4.  Start up bischeckd with:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    service bischeckd start
    ```

# Configure NSCA

For bischeck to work you need to make a couple of configuration changes.

1.  Open /etc/nsca.cfg and change:

        decryption_method=14

    to

        decryption_method=3

    There are only 3 supported methods with bischeck, 0,1 and 3. 0 = no encryption, 1 = XOR and 3 = 3DES. If using decryption\_method=3 causes performance issues lower the decryption method to 0 or 1. 

2.  Either change the password parameter in the same file to something else or copy the on already set.
3.  Restart nsca

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    service nsca restart
    ```

4.  Open up the file /opt/monitor/op5/bischeck/etc/servers.xml and edit the following two properties, here we assume that you are using encryption method 3 and has not changed the default password:

    ``` {.html/xml data-syntaxhighlighter-params="brush: html/xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: html/xml; gutter: false; theme: Confluence"}
    <property>
      <key>encryptionMode</key>
      <value>TRIPLE_DES</value>
    </property>
       
    <property>
     <key>password</key>
     <value>OP5_Monitor_R3Mote_Probe</value>
    </property>
    ```

5.  Restart bischeckd

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    service bischeckd restart
    ```

More reading regarding configuring Bischeck can be found here: [Getting started with Bischeck](Getting_started_with_Bischeck)

