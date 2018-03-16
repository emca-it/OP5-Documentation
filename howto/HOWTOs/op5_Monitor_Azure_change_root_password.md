# OP5 Monitor Azure, change root password

 

 

# Background

When spinning up a virtual OP5 Monitor system in Azure marketplace the root password is not set. The root password is needed to use the OP5 Portal to update the system, configure mail services and load a license. It is possible to do all these tasks from the command line without the root password but it is out of scope for this article.

# Scope

The scope of this article is to describe how to change the root password so it is possible to login to the OP5 Portal. How to use portal and command-line is described in the OP5 manual and other howtos. The guide assumes that you have a running system and that you have the azure user/password or ssh certificate to login. It was created when the system was initialized. 

# Step-by-step guide to change the root password

 

1.  SSH to your OP5 Monitor system
    On windows: Download putty [here](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html)
    Connect to your OP5 Monitor system
    On unixlike system i.e. : 

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    #ssh -l azureuser <ipadress>
    ```

    Accept the new hosts RSA key by entering yes
     

2.  Run a command to change the root password

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    [azureuser@op5peter2 ~]$ sudo passwd root
    We trust you have received the usual lecture from the local System
    Administrator. It usually boils down to these three things:
    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.
    [sudo] password for azureuser: 
    Changing password for user root.
    New password: 
    Retype new password: 
    passwd: all authentication tokens updated successfully.
    ```

    Congratulations, now you have changed the root password. 
     

3.  Now you can log in to the portal. For more information see [System Configuration Manual](https://kb.op5.com/x/0ATx)

 

 

1.  

    **Content by label**

    There is no content with the specified labels

