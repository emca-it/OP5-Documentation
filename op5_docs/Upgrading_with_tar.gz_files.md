# Upgrading with tar.gz files

# About

Before you start with the upgrade you need to make sure you have the login to the download sections at [www.op5.com](http://www.op5.com). Otherwise you will not be able to download the `tar.gz` files. 
To create an account please go to http://www.op5.com/sign-in/

**Table of Content**

-   [About](#Upgradingwithtar.gzfiles-About)
-   [To upgrade with tar.gz files](#Upgradingwithtar.gzfiles-Toupgradewithtar.gzfiles)

# To upgrade with tar.gz files

1.  Download the `tar.gz` file from <http://www.op5.com/download-op5-monitor/archive/>. Find the `tar.gz` file you need. You might need to open up the Archived files at the bottom of the page.
2.  Upload the `tar.gz` file to the op5 Monitor server.
3.  Login to the op5 Monitor server via ssh as the `root` user.
4.  Untar the `tar.gz` file in the `root/` folder.
5.  Go to the folder that was extracted from the `tar.gz` file.
6.  Now start the upgrade by executing the following script: `./install.sh`

