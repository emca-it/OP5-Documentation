# Running OP5 Monitor in a virtual environment

op5 packages a ready-built Virtual Appliance System (vAPS) available as an image in the .OVF format, ready to deploy in most virtualization environments, which can be downloaded [here](https://www.op5.com/download/). You can easily upgrade from the free trial to a fully supported vAPS by deploying your license file - there is no difference in the actual image.

However, there are some things you should keep in mind when considering deploying OP5 Monitor in a virtual environment, in order to avoid common pitfalls;

- The timing of monitoring will not be completely accurate
  - The virtual system gets CPU cycles as decided by the hypervisor
  - This means that millisecond timing in things such as round-trip times and transactions will not be 100% correct
  - The problem gets worse in a busy virtual environment
- You want to keep your monitoring system as independent of other devices as possible
  - A virtual environment normally relies on a SAN, the hypervisor, host hardware and other devices.
  - Making the monitoring system dependent on a complex chain of devices in order to monitor the chain itself is not an ideal situation.
  - Your virtual environment is a basket with many eggs in it - should it go down, you probably want to know very quickly. Deploying your monitoring in your virtual environment ensures that it will go down along with all the other machines - depriving you of your monitoring system when you need it the most.
- Hardware access from a virtual machine is difficult
  - We use a GSM gateway for sending SMS messages. This uses a serial port. Physical serial ports are obviously not available in a virtual machine.
  - Some hypervisors offer a virtual serial port that connects the virtual machine to the host serial port, but this ties a virtual machine to a particular host, negating the advantage most hypervisors give you of failover and high availability migration between hosts.
  - There are IP-to-serial devices so your virtual machine can speak IP to a device that converts to serial, but these introduce another single point of failure.

If you feel that you can live with the above issues, we do support running OP5 Monitor in a virtual machine, either by deploying our vAPS (Virtual Appliance System) or by installing the software version in your own virtual machine.

Should you encounter performance or reliability issues because of running in a virtual machine we will however reserve the right to recommend you switch to a physical machine for your monitoring. In relation to this, old versions of OP5 Monitor (5.7 or older) are not recommended for virtual deployment due to higher levels of CPU usage and disk activity, compared to more recent versions of the software (5.8 and later).
