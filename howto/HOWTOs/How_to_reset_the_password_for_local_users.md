# How to reset the password for local users

Version

This article was written for version 7.3.4 of Monitor, it could work on both lower and higher version if nothing else is stated.

Articles in the Community-Space are not supported by OP5 Support.

All local user passwords are stored in /etc/op5/auth\_users.yml, and they are listed as blocks like these. The string "\$1\$VGn0CdSG\$AMJjvHoF8M2nSy8SiPrW70" is a hash of the password "monitor":

    monitor:
      username: "monitor"
      realname: "Monitor Admin"
      password: "$1$VGn0CdSG$AMJjvHoF8M2nSy8SiPrW70"
      groups:
        - "admins"
      password_algo: "crypt"
      modules:
        - "Default"

The monitor command that changes the local users, including their passwords, is "/usr/bin/op5-manage-users". Running 'op5-manage-users' without any arguments prints its syntax help:

    monitor:
    This is a small helper for adding/changing/deleting users in OP5 Monitor.

    Create/edit user:
      /usr/bin/op5-manage-users --update --username=<username> (--password=<password>) --module=<module1> [--module=<modulen>] [--realname=<realname> --group=<group1> [--group=<groupn>]]
      --username    User's username
      --password    Password is only required if an authentication module that requires passwords is chosen
      --module      Authentication module that should be used for this user
      --realname    Full name of user
      --group       User's group memberships

    Delete user:
        /usr/bin/op5-manage-users --remove --username=<username>

Here is an syntax example for creating a new Monitor user, 'gord':

    monitor:
    /usr/bin/op5-manage-users --update --username=gord --realname="Wheat King" --modules=Default --password=100thMeridian --group=admins

Here is the resulting content in 'auth\_users.yml':

    monitor:
    gord:
      username: "gord"
      realname: "Wheat King"
      password: "$1$s4gwhkvu$2ZB0.yHVSkcxWUtxtuLYX0"
      password_algo: "crypt"
      modules:
        - "Default"
      groups:
        - "admins"

### Important Caveats --

- 'op5-manage-users' does not append; it only overwrites every entry for the user. For example, attempting to change only the group of the user created earlier:

        monitor:
            op5-manage-users --update --username=gord --group=limited_edit

    ...leads to this being the entire entry for the user. The password and all other entries have been removed:

        monitor:
        gord:
          username: "gord"
          groups:
            - "limited_edit"

- Changing the variable order in the command will move the user's real name to the bottom of the file entry. For example, this will run successfully:

        monitor:
        op5-manage-users --update --username=jfriday --realname="Sgt. Joe Friday" --group=admins --password=Badge714 --modules=Default

    The resulting entry in 'auth\_users.yml' can be difficult for a user to parse:

        monitor:
        jfriday:
          username: "jfriday"
          password: "$1$DTVh5ZeF$Tm1WeJDyH2AaY3FQ21Li4."
          password_algo: "crypt"
          modules:
            - "Default"
          groups:
            - "admins"
          realname: "Sgt. Joe Friday"
