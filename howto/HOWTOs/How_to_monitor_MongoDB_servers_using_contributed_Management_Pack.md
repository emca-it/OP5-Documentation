# How to monitor MongoDB servers using contributed Management Pack

This howto will cover the basic steps involved to get you started with MongoDB monitoring using community plugins in combination with our Management Packs.

The use of custom/community plugins or scripts in OP5 Monitor is not officially supported by OP5 Support. Using 3rd party packages or scripts is sometimes needed and you are allowed to do so at your own risk, make sure to keep backups of your plugins/scripts and any dependencies installed as well keeping up-to-date documentation so you are able to restore them later on if lost during an system upgrade or migration.

## Step-by-step guide

1. Download the Management pack called MongoDB Servers.json from our contributed section here: <https://kb.op5.com/x/LwJH>
2. Import the management pack in the configuration page, if you want more info about this step please go to the [Administrator manual pages ](https://kb.op5.com/display/DOC/Managing+objects#Managingobjects-Managementpacks)
3. The community project Nagios-MongoDB was used for this management pack and needs to be installed including a few dependencies but is easy to do
    1.  SSH to your OP5 Monitor server and run
        `wget https://github.com/mzupan/nagios-plugin-mongodb/archive/master.zip`
    2.  Unzip the file and copy the plugin to the custom-plugins directory:
        `unzip master.zip && cp nagios-plugin-mongodb-master/check_mongodb.py /opt/plugins/custom/`
    3.  The plugin requires a python module called "pymongo" and the easiest way to install it is by using pip, however pip is not installed by default so lets install pip and a few other packages needed:
        `yum install gcc python-devel python-pip`
    4.  Next install the required module using pip:
        `pip install pymongo`

4. Now you are ready to use the MongoDB management pack!
