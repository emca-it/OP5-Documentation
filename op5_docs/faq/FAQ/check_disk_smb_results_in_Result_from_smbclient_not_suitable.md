# check\_disk\_smb results in Result from smbclient not suitable

## Question

* * * * *

The *check\_disk\_smb* check plugin results in *Result from smbclient not suitable.*

`$ /opt/plugins/check_disk_smb -H host -s share -u username -p password`
`Result from smbclient not suitable`

 

## Answer

* * * * *

Some additional debug information can be found by including the *-v* argument the check plugin's command line. This enables verbose output.

`$ /opt/plugins/check_disk_smb -H host -s share -u username -p password -v`
`/usr/bin/smbclient //host/share -U username%password -c du`
`Result from smbclient not suitable`
`UNKNOWN`

 

An error code can be found by running the smbclient command line as shown in the output above.

`$ /usr/bin/smbclient //host/share -U username%password -c du`
`Domain=[OP5] OS=[Windows Server 2008 R2 Enterprise 7600] Server=[Windows Server 2008 R2 Enterprise 6.1]`
`tree connect failed: NT_STATUS_DUPLICATE_NAME`

 

Microsoft provides a workaround [at this page](http://support.microsoft.com/kb/281308) (have a look at the recommended way of resolving this in *Windows Server 2003*). Once the registry has been modified as described, instead of restarting the computer, simply restarting the *Server* service in Windows seems to do the trick.

 

In this case, the issue was resolved by applying the workaround.

`$ /usr/bin/smbclient //host/share -U username%password -c du`
`Domain=[OP5] OS=[Windows Server 2008 R2 Enterprise 7600] Server=[Windows Server 2008 R2 Enterprise 6.1]`
`65535 blocks of size 65536. 64762 blocks available`
`Total number of bytes: 0`

`$ /opt/plugins/check_disk_smb -H host -s share -u username -p password`
`Disk ok - 3.95G (98%) free on \\host\share | 'E$'=50659328B;3650666496;4080156672;0;4294901760`

