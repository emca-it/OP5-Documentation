# Replicate Tactical Overview from one user to another

## Question

* * * * *

How do I replicate a Tactical Overview from one user to another?

## Answer

* * * * *

This article will show you how to copy the settings from one users TAC to another. The guide applies to both existing local users in op5 Monitor and users authentication from LDAP/AD, existing and also users that never logged in to op5 Monitor.

The example below is intended for the op5 Monitor administrator that wants to define a common view on Tactical Overview.

Linux command line experience and basic knowledge of MySQL is required.

 

This article is intended for use on op5 Monitor 7.1.5. The behaviour might change in later versions of the product.

 

Settings *source user*: **monitor**

Target *user*: **newuser**

 

1. Log in to op5 Monitor user interface and configure a Tactical Overview  with a user that reflects what should be replicated to multiple users in the GUI on the *source user*.

2. Log in as root via ssh on your op5 Monitor server

3. Take a backup of the database prior to doing any changes:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# mysqldump merlin ninja_settings ninja_widgets > /root/merlin_tac_backup.sql
```

 

3. Enter the database "merlin"

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
# mysql merlin
```

 

4. Have a look at the structures for the settings configured for the user you want to replicate to get a general understanding of the structure:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
mysql> SELECT * FROM ninja_widgets WHERE username = 'monitor' AND page = 'tac/index';

+----+----------+-----------+-----------------------------+---------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| id | username | page      | name                        | friendly_name                   | setting                                                                                                                                                        | instance_id |
+----+----------+-----------+-----------------------------+---------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
| 33 | monitor  | tac/index | tac_synergy                 | Business Services               | a:0:{}                                                                                                                                                         |     6573858 |
| 42 | monitor  | tac/index | nagvis                      | NagVis                          | a:0:{}                                                                                                                                                         |     3919371 |
| 43 | monitor  | tac/index | netw_health                 | Network health                  | a:4:{s:16:"refresh_interval";s:3:"120";s:25:"health_warning_percentage";s:2:"90";s:26:"health_critical_percentage";s:2:"90";s:17:"visible_precision";s:1:"2";} |     5712776 |
| 48 | monitor  | tac/index | tac_services_unacknowledged | Unacknowledged service problems | a:5:{s:16:"refresh_interval";s:3:"120";s:18:"service_box_height";s:1:"0";s:8:"critical";s:1:"1";s:5:"group";s:3:"all";s:4:"hard";s:1:"1";}                     |     2036109 |
| 49 | monitor  | tac/index | tac_problems                | Unhandled problems              | a:0:{}                                                                                                                                                         |     4740640 |
+----+----------+-----------+-----------------------------+---------------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------+-------------+
5 rows in set (0.00 sec)
```

The above data will be replicated from the user "**monitor**" to  "**newuser**".

5. Remove the settings for the user you want to change. Also  change the username field from **newuser** to a actual user in your system:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
mysql> DELETE FROM ninja_widgets WHERE page = 'tac/index' AND username = 'newuser';
mysql> DELETE FROM ninja_settings WHERE page = 'tac/index' AND username = 'newuser';
```

The above is not necessary if preparations are made for a new user that haven't logged in before.

 

6. Now it's time to copy the widgets from the user "**monitor**" to the user "**newuser**" Change the query to reflect your username you want to copy the settings too:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
mysql> INSERT INTO ninja_widgets (`username`,`page`,`name`,`setting`,`friendly_name`,`instance_id`) SELECT 'newuser' AS username, `page`,`name`,`setting`,`friendly_name`,`instance_id` FROM ninja_widgets WHERE username = 'monitor';
```

 

7. Update the settings table for the widgets that you copied to "**newuser**" in stage 6:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
mysql> INSERT INTO ninja_settings (`username`,`page`,`type`,`setting`,`widget_id`) SELECT 'newuser' AS username, `page`,`type`,`setting`,`widget_id` FROM ninja_settings WHERE username = 'monitor';
```

 

8. Log in as **newuser** in the user interface to verify that all settings were copied correctly.

