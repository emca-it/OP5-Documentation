# Performance tests of the generation 7 appliance servers

## Background

We have previously been lacking well tested and relevant documentation on what kind of performance our customers could expect from our appliance servers. To provide more reliable information, we have now performed proper performance tests of our new appliances, which enables us to deliver better estimates and allow for more accurate decisions when designing and sizing monitoring environments.

Since every customer environment is unique, we decided not to try to test anything that wasn’t repeatable and verifiable, and thus we could only test the Monitor side of things. A shell script plugin to generate random data with random perfdata and sleep for a random amount of time was written to have a worst-case scenario where every service had perfdata and every service had to fork bash. In this way, we could test Monitor without introducing unrepeatable dependencies such as network latencies etc.

The machines were tested with 6.1-beta, and since no significant changes with regards to Merlin or Nagios performance has been introduced during the beta period, we feel confident that the numbers can be trusted.

The full data set is approximately three months, but we decided to present a week of data for this report, mainly because the data doesn’t really change between weeks and we saw no trends of increasing memory usage or memory leaks that would show up in larger sample sets.

The setup

The test setup consisted of three machines:

- ps-dev, a virtual machine running Monitor, for collecting data
- fnord-perf-std, a G7 Standard appliance
- fnord-perf-large, a G7 Large appliance

The G7 Standard is a Dell PowerEdge R420 with one Intel Xeon E5-2420 and 16 GB of memory, with a Dell PERC H310 hardware RAID card running RAID1 on two 300GB 15kRPM SAS drives.

The G7 Large is a Dell PowerEdge R620 with two Intel Xeon E5-2620 and 24 GB of memory, with a Dell PERC H710 hardware RAID card running RAID10 on four 300GB 15kRPM SAS drives.

 Since we didn’t have a G7 Entry at our disposal, it couldn’t be tested. However, we feel that it will definitely handle the low amount of hosts/services that we recommend for it.

The configuration was generated with the “mon test dist” command. Commands used to generate configuration were, for the Large machine:

    mon test dist --confgen-only --hosts=500 --services-per-host=100 --masters=2 --poller-groups=1

..and for the Standard machine:

    mon test dist --confgen-only --hosts=100 --services-per-host=100 --masters=2 --poller-groups=1



We then took the config for the peer group “master” only, and modified shared.cfg to use the custom check plugin. We then created a subdirectory to nagios’ etc directory, and pointed cfg\_dir there in nagios.cfg.

A list of all installed packages on the system is in appendix C.

You can find the actual config and plugins used for these machines here:

[g7-perf-test.tar.gz](attachments/3801722/4358201.gz)

In order to see how the load was divided between the CPU cores (and Hyperthreading virtual cores), we wrote a custom plugin to collect CPU load, and a PNP template to graph it in a meaningful way. In addition, we also used check\_mem to get relevant memory information together with a PNP template to graph that too.

As you can see from the configs, the Large appliance uses a config with 100.000 services, and the Standard appliance uses a config with 20.000 services. These numbers are based in experiments we did to figure out a sweet spot for both machines to have a low enough load that adding on the real-world load from various plugins would still result in a responsive system. The check interval was set to the standard 5 minutes.

The plugin we wrote simulates a standard plugin that asks for something, waits for a response and then outputs data and performance data. It works like this:

1. Generate a random value between 0 and 10.
2. If the value is between 0 and 7, sleep for a random time between 0 and 15 seconds, and then return OK, with the random value and random sleep values as performance data.
3. If the value is 8, sleep for a random time between 0 and 15 seconds, and then return WARNING, with the random value and random sleep values as performance data.
4. If the value is 9, sleep for a random time between 0 and 15 seconds, and then return CRITICAL, with the random value and random sleep values as performance data.
5. If the value is 10, sleep for a random time between 0 and 15 seconds, and then return UNKNOWN, with the random value and random sleep values as performance data.

This, of course generates many, many more state changes than a normal system would ever see, but we wanted to set up a “worst possible scenario” while still being somewhat realistic in regards to the kind of ratio between results one would see in real life.

## Results

We will let the fancy graphs speak for themselves. These are over a one week period.

### Standard appliance

![](https://lh5.googleusercontent.com/zuN973LL1XzDrH-KhOyoFn9-aPeHHLE7ixx9S-1fdnvAVbdQ3hE23vzDgXJzqtDAqV6jXapElSOk0BwSUdQgZCn842gOv2DGTuB7RPSVEGyJY6-bH6zkGKRMGQ)

![](https://lh6.googleusercontent.com/KNi2-vKAyxajkrD9UHau6o_03_tSG9tqwdljEeru0NUaM25TKivbDGwiXwGyRiM1-7OYe_bhuFHUahpLnYGQxaOIjJAh-pk_rh1snISWdrkcmABGlnWzYMn6NA)

As you can see, we stay comfortably at an average of just over 11% CPU load, and memory usage never exceeding 5.13GB (of the Standard appliance’s 16GB), which means there is lots of room for the real-world load. 15 minute load peaked at 2.25 (on 12 cores/Hyperthreads). Check latencies were 0.86 seconds max and 0.003 seconds avg.

A Dell DPACK report for the Standard appliance is in appendix A, where you can see I/O load, average transfer sizes, etc.

A bonnie++ storage benchmark for the Standard appliance is in appendix B, for raw storage subsystem performance.

### Large appliance

![](https://lh6.googleusercontent.com/2dRn9EvIEtiTGzCn4yb_isz0RGbGzN-UvbDDKeG2_7CMTIgZj9X7E85EmXCkxWRrNL70D42UqEywVyDBziC0G04lxg8SXV7IeH05BLjeHCjYtesRNtXI1_Wgfg)

![](https://lh5.googleusercontent.com/z6E3rRdM0-Ms4_F1QW36drIfacjgWsa-siAbhxRpsKlAWA1iuyVDIxerz7DBplO-EfKkOzmTqZ_pQC6Wg7-AHY3HuUqfDBVleI5elYPTGylPG0RyCgBvOOox0A)

 Again, we’re very comfortable at an average load of a little less than 15%, and memory usage peaking at 9.43GB of the Large appliance’s 24GB. 15 minute load peaked at 3.89 (on 24 cores/Hyperthreads). Check latencies were 0.8 seconds max and 0.002 seconds avg.

A Dell DPACK report for the Large appliance is in appendix A, where you can see I/O load, average transfer sizes, etc.

A bonnie++ storage benchmark for the Large appliance is in appendix B, for raw storage subsystem performance.

## Conclusion

Our new appliances are immensely powerful machines, especially in combination with Monitor 6 / Nagios 4. We are able to deliver tens of times more performance than the older platform of G6 appliances and Monitor 5 / Nagios 3.

After running these tests over an extended period of time, we feel we can safely stand by the following numbers as a recommendation for a suitable load for these systems.

For the **G7 Large appliance**, we recommend a **maximum real world load** of **100.000 services**, which represents a little over **11.000 hosts** at the average of 9 services per host.

For the **G7 Standard appliance**, we recommend a **maximum real world load** of **20.000 services**, which represents a little over **2.200 hosts** at the average of 9 services per host.

These numbers will always be a guideline rather than a solid limit, since all checks are different, but they should give a very good idea of what you want to be aiming for when you size your system.

Keep in mind that some plugins (SNMP interface checks with the Perl checks, check\_vmware\_api, etc) use a lot of resources, so you will have to adapt these recommendations to the kind of environment the system will be deployed in.

We hope you, dear reader, have a better understanding of the scaling of OP5 Monitor now than when you started reading this document. Thank you for your time!

## Appendix A - Dell DPACK performance reports

Dell DPACK is a performance analytics tool to analyze primarily storage performance, but with some other metrics included. It can be found here:

<http://www.dell.com/Learn/us/en/04/campaigns/dell-performance-analysis-collection-kit-dpack?c=us&l=en&s=bsd>

The DPACK reports can be found in the same tarball as the configuration and other data:

[g7-perf-test.tar.gz](attachments/3801722/4358201.gz)

## Appendix B - bonnie++ reports

bonnie++ is a hard drive and file system speed benchmark. It can be found here:

<http://www.coker.com.au/bonnie++/>

For the G7 Standard, bonnie++ was run with the following parameters and resulting data:

    [root@r19-standard ~]# bonnie++ -d ./bonnie-temp/ -s 32g -m standard -f -b -u root

    Using uid:0, gid:0.

    Writing intelligently...done

    Rewriting...done

    Reading intelligently...done

    start 'em...done...done...done...

    Create files in sequential order...done.

    Stat files in sequential order...done.

    Delete files in sequential order...done.

    Create files in random order...done.

    Stat files in random order...done.

    Delete files in random order...

    done.

    Version 1.03e       ------Sequential Output------ --Sequential Input- --Random-

                       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--

    Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP

    standard        32G           162171  12 74414   6           229003   8 361.2   1

                       ------Sequential Create------ --------Random Create--------

                       -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--

                 files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP

                    16    81   0 +++++ +++   117   0    80   0 +++++ +++   115   0

    standard,32G,,,162171,12,74414,6,,,229003,8,361.2,1,16,81,0,+++++,+++,117,0,80,0,+++++,+++,115,0

For the G7 Large, bonnie++ was run with the following parameters and resulting data:

    [root@r20-large ~]# bonnie++ -d ./bonnie-temp/ -s 48g -m large -f -b -u root

    Using uid:0, gid:0.

    Writing intelligently...done

    Rewriting...done

    Reading intelligently...done

    start 'em...done...done...done...

    Create files in sequential order...done.

    Stat files in sequential order...done.

    Delete files in sequential order...done.

    Create files in random order...done.

    Stat files in random order...done.

    Delete files in random order...done.

    Version 1.03e       ------Sequential Output------ --Sequential Input- --Random-

                       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--

    Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP

    large           48G           297357  27 142545  12           376749  14  1187   3

                       ------Sequential Create------ --------Random Create--------

                       -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--

                 files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP

                    16  1773   5 +++++ +++  1536   3   959   3 +++++ +++  1990   4

    large,48G,,,297357,27,142545,12,,,376749,14,1186.7,3,16,1773,5,+++++,+++,1536,3,959,3,+++++,+++,1990,4

    A nicer HTML table is in the same tarball as the configuration and other data:

g7-perf-test.tar.gz

## Appendix C - installed packages

Lists of the packages installed on the two systems can be found in the same tarball as the configuration and other data:

[g7-perf-test.tar.gz](attachments/3801722/4358201.gz)

