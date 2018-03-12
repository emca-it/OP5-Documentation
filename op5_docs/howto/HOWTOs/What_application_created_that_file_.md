# What application created that file?

Ever wonder what application/plugin/script that keeps creating "weird" files in /tmp or elsewhere on your machine? In this case, we have a system where the following type of files are created in /tmp and we have no idea what keeps creating them:

    -rw-r--r-- 1 monitor apache 0 29 feb 12.42 /tmp/xml5b1742fd
    -rw-r--r-- 1 monitor apache 0 29 feb 12.47 /tmp/xml7a405f88
    -rw-r--r-- 1 monitor apache 0 29 feb 12.52 /tmp/xmlcc647eda
    -rw-r--r-- 1 monitor apache 0 29 feb 12.57 /tmp/xml9626857e
    -rw-r--r-- 1 monitor apache 0 29 feb 13.02 /tmp/xml2b809cbe
    -rw-r--r-- 1 monitor apache 0 29 feb 13.07 /tmp/xml13442055
    -rw-r--r-- 1 monitor apache 0 29 feb 13.12 /tmp/xml4750b3ef

 

The answer to figuring this out is called **auditd**. First make sure you have the auditing tools installed, and make sure auditd it's started:

    # yum install audit
    # service auditd restart

 

Next, apply some auditing rules to auditd. The first one is to audit all file creations in /tmp and second to audit all executions. Beware that this may create a lot of log data, so if the files are created very infrequently, add these rules when you can expect to have the file created within a short period of time:

    # auditctl -a always,exit -F arch=b64 -F dir=/tmp -S open
    # auditctl -a always,exit -F arch=b64 -S execve

 

Now, wait until the file has been created, and then disable the rules you added above to stop logging:

    # auditctl -D

 

What we need to do now is to find the system call that performed the open() operation on the file in question, and locate the parent PID of that call. I am using one of the files from the example above:

    # ausearch -f /tmp/xml7a405f88

This renders the following output:

----
time-\>Mon Feb 29 12:47:01 2016
type=PATH msg=audit(1456746421.011:513399): item=1 name="/tmp/xml7a405f88" inode=908 dev=fd:02 mode=0100644 ouid=299 ogid=48 rdev=00:00 nametype=CREATE
type=PATH msg=audit(1456746421.011:513399): item=0 name="/tmp/" inode=2 dev=fd:02 mode=041777 ouid=0 ogid=0 rdev=00:00 nametype=PARENT
type=CWD msg=audit(1456746421.011:513399): cwd="/"
type=SYSCALL msg=audit(1456746421.011:513399): arch=c000003e syscall=2 success=yes exit=3 a0=7ffe5b700ea8 a1=941 a2=1b6 a3=7ffe5b6ff680 items=2 **ppid=6855** pid=6858 auid=4294967295 uid=299 gid=48 euid=299 suid=299 fsuid=299 egid=48 sgid=48 fsgid=48 tty=(none) ses=4294967295 comm="touch" exe="/bin/touch" key=(null)

 

There we managed to find the ppid of the process, so now we search using that as input parameter for ausearch again:

    # ausearch -p 6855

And the result:

----
time-\>Mon Feb 29 12:47:00 2016
type=PATH msg=audit(1456746420.995:513393): item=2 name=(null) inode=1700752 dev=fd:01 mode=0100755 ouid=0 ogid=0 rdev=00:00 nametype=NORMAL
type=PATH msg=audit(1456746420.995:513393): item=1 name=(null) inode=1831553 dev=fd:01 mode=0100755 ouid=0 ogid=0 rdev=00:00 nametype=NORMAL
type=PATH msg=audit(1456746420.995:513393): item=0 name="/opt/plugins/custom/create\_random\_xml.sh" inode=923993 dev=fd:01 mode=0100755 ouid=299 ogid=48 rdev=00:00 nametype=NORMAL
type=CWD msg=audit(1456746420.995:513393): cwd="/"
type=EXECVE msg=audit(1456746420.995:513393): argc=1 a0="/bin/bash"
type=EXECVE msg=audit(1456746420.995:513393): argc=2 a0="/bin/bash" a1="**/opt/plugins/custom/create\_random\_xml.sh**"
type=SYSCALL msg=audit(1456746420.995:513393): arch=c000003e syscall=59 success=yes exit=0 a0=16abb10 a1=16bc750 a2=7ffc7b68f788 a3=7ffc7b68ef10 items=3 ppid=6052 pid=6855 auid=4294967295 uid=299 gid=48 euid=299 suid=299 fsuid=299 egid=48 sgid=48 fsgid=48 tty=(none) ses=4294967295 comm="create\_random\_x" exe="/bin/bash" key=(null)

 

And there it is. **/opt/plugins/custom/create\_random\_xml.sh **is the script I created for the purpose of testing this.

 

-   Page:
    [What application created that file?](../HOWTOs/What_application_created_that_file_)

 

