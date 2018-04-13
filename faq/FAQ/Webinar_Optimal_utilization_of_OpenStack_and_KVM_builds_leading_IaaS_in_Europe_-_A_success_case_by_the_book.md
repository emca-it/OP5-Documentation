# Webinar: Optimal utilization of OpenStack and KVM builds leading IaaS in Europe - A success case by the book

### [Download OP5 Monitor Free](https://www.op5.com/download-op5-monitor/)

[![](attachments/688465/16155433.png)](https://www.op5.com/download-op5-monitor/)

#### These are the questions we received during the webinar via our online chat.

#### Q1: Is it possible to create a vlan in the interface?

A: Absolutely! You will will be able to create and connect VLAN to the private networks of OpenStack. This is most often done when physical hardware is connected to virtual hardware in OpenStack. However if you run pure OpenStack and our virtual environment you will use OpenStacks private networking functions straight up

#### Q2: Can we see stats on Load balancer?

A: Not yet but the documentation of the ceilometer api shows that some stats could be extracted. In time, we hope to be able to provide more detailed data with the help of ceilometer.

#### Q3: Have you done extensive customization of Open Stack or ar most features available out of the box??

A: We keep the foundation of OpenStack as clean as possible. What we touch are two things. If there are bugs that are not making a specific feature work - we fix it. Second - we build some functionality which is not found in OpenStack. Such as all functionality around tying multiple data centers together and making it easy for the user to use. There is a City Cloud specific API as well to make sure you can access this functionality as well. It includes but is not limited to creating networks over multiple DCs and moving volumes and servers between DCs

#### Q4: Can you set a static IP to a server to use it as an DC?

A: Openstack uses floating IPs that are bound to your account. This IP can be moved between servers as you wish and you keep it until you decide to let it go. So Yes, you can connect a floating IP to a certain server and never let it go.

#### Q5: Is it possible to mirror volumes between data centers?

A: There is an ongoing project to allow volume replication in Cinder (the block storage module), however it is not yet production ready.

#### Q6: Would definitely love to see some kind of "how to set up a DC for use with your local office through Openstack" in the future! :)?

A: For sure! There are simple ways like through VPN today. But we do see layer 2 and layer 3 options becoming more popular. With more data in external DCs the network is becoming increasingly important. We see you using your ISP for the fiber but for transit and other layers will be handled by many cloud providers for lower latency and higher level services (DDoS and more).

If you want to get in touch with City Network you can visit City Network website and contact them via phone or email.

### [Download OP5 Monitor Free](https://www.op5.com/download-op5-monitor/)

[![](attachments/688465/16155433.png)](https://www.op5.com/download-op5-monitor/)
