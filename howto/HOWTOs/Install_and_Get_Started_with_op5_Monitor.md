# Install and Get Started with OP5 Monitor

**Related Links:**

[OP5 Monitor 7.3 User Manual as a PDF](https://kb.op5.com/download/attachments/16482327/op5_Monitor_7.3_user_manual.pdf?api=v2)

[OP5 Monitor 7.3 Admin Manual as a PDF](https://kb.op5.com/download/attachments/16482327/op5_Monitor_7.3_admin_manual.pdf?api=v2)

# License

The trial license for OP5 Monitor lets you monitor an unlimited amount of hosts and devices with an infinite number of services for 30 days. After 30 days, there will be an opportunity to purchase a permanent license.

# Download and installation of OP5 Monitor

There are three different installation options for OP5 Monitor: Virtual Appliance, Software, and Cloud Server.

To deploy on a Windows machine without Linux, use the Virtual Appliance option.

All downloads can be found at [our Download page](https://www.op5.com/download/).

## Virtual Appliance

The Virtual Appliance is used on hypervisors, such as VMware or VirtualBox. Other hypervisors that can import OVFs may also be able to import this OVF successfully.

The Virtual Appliance's OVF includes a CentOS 6 VM with OP5 Monitor already installed and partially configured. This is the easiest and quickest way to get started. After downloading and starting the appliance, the server will get a DHCP address and show that address in the console's login screen.

For help with installing the Virtual Appliance, please visit [our page about getting started with our virtual server](https://old.op5.com/how-to-get-started-op5-monitor-virtual-server/)

## Software

To install, you will need a running CentOS 6 or RHEL 6, which is not included with this installation. Look for version 7 to be supported in a future release. Installation

### Installation

1. Download OP5 Monitor to your home directory
2. Unpack the tar.gz file
3. Go to the newly created folder
4. Run ./install.sh

        For additional steps with installing the software, please visit [our older Monitor installation page](https://old.op5.com/get-started-with-op5-monitor-software-installation/).

## Cloud Server

Cloud servers are available at Amazon, Azure, and CityCloud. Although the OP5 Monitor license is still free, you will need a subscription for any of the Cloud server providers. Installation instructions can be found on those sites accordingly. However after getting it up and running, there is no appreciable difference between a cloud server and software installation. After the cloud server installation, OP5 Monitor can be installed using the same steps as the software installation.

# Accessing Your New OP5 Installation

op5's main interface can be easily accessed using any web browser. In addition to monitoring your network in a unified, single pane of glass, most configuration options can be accessed via the graphical user interface.

1. Using a web browser, navigate to <https://your.op5.svr>, where 'your.op5.svr' is either the IP address (such as **172.16.5.5**) or host name (such as **op5box.foo.net**) of the new OP5 Monitor server on your network.

2. From the “Start” tab, click the "OP5 Monitor" button.

3. You will be prompted to create an account with administrator privileges the first time you access OP5 Monitor.

If you see a warning when first launching the web GUI, don't panic!  This warning is not an issue with the OP5 application, and poses no real risk.  op5 ships by default with self-signed SSL Certificates, a common practice when deploying any new web service that is secured via SSL.  The warning page can safely be skipped using any browser by adding an exception:

Chrome - Click "Advanced," then "Proceed to example.com"

Firefox - Click "I Understand the Risks," then "Add Exception," and finally "Confirm"

Internet Explorer - Click on "Continue to this website (not recommended) to bypass SSL warning in Internet Explorer."

To fix the issue permanently, refer to the following OP5 KB article:  Add or renew an SSL certificate for OP5 Monitor

# Server Configuration

## Virtual Appliance

The Virtual Appliance version uses the web-based system configuration tool to set the IP address, hostname, mail gateway, and other local aspects.

To enter the configuration tool:

1. Use a web browser and navigate to <https://your.op5.svr>, where 'your.op5.svr' is either the IP address (such as **172.16.5.5**) or host name (such as **op5box.foo.net**) of the new OP5 Monitor server on your network.

2. Select "Configure System" from the top menu. The default password is: ***monitor***

![Configure Monitor link in the top menu](attachments/15795240/16155454.png) \


3. Configure IP address, hostname, and mail gateway as needed.

## Software

The software version does include the web-based "Configure System" tool, but is limited to license management. You will need to configure the system settings such as IP address, hostname and mail gateway through Linux.

Note: This is strictly referring to the "Configure System" tool. This is not the "OP5 Monitor Configuration" tool that is used to configure OP5 Monitor, hosts, services, contact groups, and so forth.

Additional information can be found in the manual chapter [Manually from the prompt](https://kb.op5.com/display/DOC/Manually+from+the+prompt).

# Prepare servers or network equipment to be monitored

Before a server or network equipment can be monitored, you may require a particular agent. It can either be NSClient++ for Windows, NRPE for Linux, or SNMP for network equipment.

## NSClient++

NSClient++ (abbreviated to NSCP) is the rising star of monitoring agents. Though originally designed as the Windows version of NRPE, it has versions for Linux and other operating systems. You can download the latest version [directly from the NSCP site](https://nsclient.org/download/).

Remember to allow your OP5 server to query the agent. You configure this during the installation of the agent, which you can also [learn about directly from NSCP's site](https://docs.nsclient.org/getting_started/).  

## NRPE (Nagios Remote Plugin Executor)

You can download the NRPE installer from [their GitHub page](https://github.com/NagiosEnterprises/nrpe) or from the repository of your distribution. While our version contains some pre-configured items, the rest of this version of NRPE may have security vulnerabilities due to its age.

Remember to allow your OP5 server to query the agent. This involves changing the settings in */etc/nrpe.conf* under the 'allowed\_hosts' option.

## SNMP

Though SNMP can be used in both Windows and Linux environments, most administrators would save its use for networking equipment and older devices without web or API interfaces. Enabling SNMP on your equipment may differ from device to device. Please see your device's manual and review [our SNMP documentation](https://kb.op5.com/x/LYTf).

# Adding your first server

OP5 Monitor includes a "Host Configuration Wizard" for easy deployment and configuration of your network devices. This wizard includes pre-configured management packs for each device. We will start off by demonstrating how to deploy a device by using the "Host Configuration Wizard":

1. Use a web browser and navigate to <https://your.op5.svr/monitor>, where 'your.op5.svr' is either the IP address (such as **172.16.5.5**) or host name (such as **op5box.foo.net**) of the new OP5 Monitor server on your network.

2. Navigate to the Host Wizard, which is found in the configuration menu.

    ![Configuration -> Host Wizard](attachments/12976421/13271087.png) \


3. Select the type of server or device you will want to monitor. We will use a Windows Server as an example:

    ![](attachments/12976421/13271088.png) \


4. Click on "Next."

5. Enter server name and the IP address of the server.

    ![](attachments/12976421/13271089.png)


6. Click on "Next".

7. Click on "Save Configuration and View Added Hosts":

    ![](attachments/thumbnails/12976421/13271090) \


Done!
