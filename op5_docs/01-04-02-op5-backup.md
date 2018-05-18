# op5-backup

## About

 The op5-backup script is a script that backs up the OP5 installation.

It does not backup the operating system nor does it include logger data.

## Configuration

The configuration for op5-backup is located in:

``` {style="margin-left: 30.0px;"}
/etc/op5-backup/main.conf
```

op5-backup support local or ftp/sftp backup. Local backup can be done to a mounted share.

## Create a backup

### Creating a full backup

A full backup will back up the following (if installed):

- op5-system
- op5-monitor
- op5-plugins
- Docuwiki
- Logserver
- Trapper

To run a full backup of your OP5 server type in the console:

``` {style="margin-left: 60.0px;"}
op5-backup
```

If you like to run the interactive op5-backup, use the -i option:

``` {style="margin-left: 60.0px;"}
op5-backup -i
```

The backup file will be stored in the location specified in the configuration file.

### Creating a custom backup

It is possible to exclude or include different modules in a backup.
 To get a list of the different modules type:

``` {style="margin-left: 60.0px;"}
ls /etc/op5-backup/modules/legacy
```

To create a backup that excludes a specific module type:

``` {style="margin-left: 60.0px;"}
op5-backup – -<module1> -<module2>
```

To create a backup that includes only the specified modules type:

``` {style="margin-left: 60.0px;"}
op5-backup – +<module1> +<module2>
```

### Creating a change arch backup

A change arch backup is used when i.e backing up a 32-bits system and restore it on a 64-bits system.
 To create a change arch backup type:

``` {style="margin-left: 60.0px;"}
op5-backup -m charch
```

It is also possible to combine this with the include/exclude modules option.
 I.e we what to create a backup of a 32-bit system with the system configuration to restore that on a 64-bits system.

``` {style="margin-left: 60.0px;"}
op5-backup -m charch – -op5-system
```

A change arch backup will convert all graphs, in a large installation with a lot of history this can take up to a couple of hours.

## Restoring a backup

## To restore a full backup type:

``` {style="margin-left: 30.0px;"}
op5-restore -b <path to backup file>
```

Only do a full restore when using a local terminal. Do not restore via SSH. The session will be lost if the network service is restarted.

## Verify a backup

It is very good practice to verify the backups from time to time. Especially after a manual backup.
 This is done using SSH or the console of the OP5 server.

``` {style="margin-left: 30.0px;"}
tar vft <backup-file>
```

Depending on what modules was used for the backup the list will vary. This is an example of a migration backup:

``` {style="margin-left: 30.0px;"}
rw-r r- root/root 1476847 2013-05-08 08:23 dokuwiki.tar.gzrw-r r- root/root 514982 2013-05-08 08:23 migrate.tar.gzrw-r r- root/root 296954 2013-05-08 08:23 nagios-plugins.tar.gzrw-r r- root/root 1052 2013-05-08 08:23 op5-geomap.tar.gzrw-r r- root/root 26274 2013-05-08 08:23 op5-logserver-3.tar.gzrw-r r- root/root 27206917 2013-05-08 08:24 op5-monitor.tar.gzrw-r r- root/root 142 2013-05-08 08:24 op5-notify.tar.gzrw-r r- root/root 409 2013-05-08 08:24 op5-synergy.tar.gzrw-r r- root/root 203002 2013-05-08 08:24 op5-system.tar.gzrw-r r- root/root 1917 2013-05-08 08:24 ssh.tar.gzrw-r r- root/root 4 2013-05-08 08:24 versionrw-r r- root/root 16 2013-05-08 08:24 timestamprw-r r- root/root 7 2013-05-08 08:24 architecturerw-r r- root/root 8 2013-05-08 08:24 moderw-r r- root/root 7 2013-05-08 08:24 archivedrwxr-xr-x root/root 0 2013-05-08 08:24 modules/rw-r r- root/root 147 2013-05-08 08:23 modules/op5-geomaprw-r r- root/root 3284 2013-05-08 08:23 modules/op5-monitorrw-r r- root/root 136 2013-05-08 08:24 modules/op5-notifyrw-r r- root/root 518 2013-05-08 08:24 modules/op5-systemrw-r r- root/root 865 2013-05-08 08:23 modules/op5-logserver-3rw-r r- root/root 5813 2013-05-08 08:23 modules/migraterw-r r- root/root 116 2013-05-08 08:24 modules/sshrw-r r- root/root 165 2013-05-08 08:24 modules/op5-synergyrw-r r- root/root 646 2013-05-08 08:23 modules/dokuwikirw-r r- root/root 177 2013-05-08 08:23 modules/nagios-plugins
```

## Deleting a backup

Deleting a backup is really easy. It is just a matter of deleting the backup file. If the backup files are stored on the op5-server enter

``` {style="margin-left: 30.0px;"}
rm <backup-file>
```

Or if the file is stored on a network share, you can browse the network share from any computer to delete the file.
