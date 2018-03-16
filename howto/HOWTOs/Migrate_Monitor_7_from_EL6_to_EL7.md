# Migrate Monitor 7 from EL6 to EL7

Need help migrating? Contact your sales representative and let our Professional Services assist you.

Note: This guide assumes that you are running some version of Monitor 7. This HOW-TO does not apply to earlier versions of Monitor.

Note: Running different RHEL versions in a distributed environment is not supported!

 

Step-by-step guide

1.  Install and set up EL7 on new machines. The number of machines you should set up should match the number of machines in your current Monitor cluster.
2.  Upgrade the old machines to the latest version of Monitor 7 via yum
3.  Make a clean install of Monitor on the new machines. This should also be the *same* version of Monitor that you upgrade *to* in previous step.

4.  Stop monitor on all machines, both new EL7 and old, by running the following command on all machines:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    # mon stop
    ```

5.  Configure NTP, DNS etc and prepare for IP-change

6.  For each of your EL6 machines make a backup by running the following command:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    # op5-backup -- -sysconfig
    ```

    Backup file location can be found in op5-backup configuration, more information can be found here: <https://kb.op5.com/x/QoD7>

7.  Copy the backup file from each old machine onto each respective new machine, so that each new machine has one backup file.

8.  Shut down the old machine, and apply its IP settings on the new machine(s)

9.  For each new machine, restore the backup file by running the following command:

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    # op5-restore -b <backup file>
    ```

10. After restoring you will need to reboot

## Related articles

-   Page:
    [Upgrade paths for OP5 products](/display/HOWTOs/Upgrade+paths+for+op5+products)
-   Page:
    [Getting started with OP5 Monitor](/display/HOWTOs/Getting+started+with+op5+Monitor)
-   Page:
    [Configure a Linux server for SNMP monitoring](/display/HOWTOs/Configure+a+Linux+server+for+SNMP+monitoring)
-   Page:
    [Migrate Monitor 7 from EL6 to EL7](/display/HOWTOs/Migrate+Monitor+7+from+EL6+to+EL7)
-   Page:
    [How to migrate from Monitor 5.8.x to 7.x on OP5 APS](/display/HOWTOs/How+to+migrate+from+Monitor+5.8.x+to+7.x+on+op5+APS)

## Comments:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><p>Q: Are there special things to consider if/when you run monitor in a distributed set-up? Can customers have Monitor v7.3 on RHEL 6 on a master and pollers running on Rhel 7? If there are limitations or considerations, these should be noted at the top of the document. </p>
<img src="images/icons/contenttypes/comment_16.png" /> Posted by janj at Jul 05, 2017 01:45</td>
<td align="left"><p>It's possible that it might work but it's nothing we support, so will add that note. Good point!</p>
<img src="images/icons/contenttypes/comment_16.png" /> Posted by rengstrom at Jul 05, 2017 02:01</td>
</tr>
</tbody>
</table>


