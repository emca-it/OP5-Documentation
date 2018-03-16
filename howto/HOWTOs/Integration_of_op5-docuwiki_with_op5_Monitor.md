# Integration of op5-docuwiki with OP5 Monitor

## Introduction

op5 dokuwiki is a simple web-application making it easy for anyone to add, remove and edit web pages. One possible area of use is as a simple inventory system storing information regarding hosts and services. It  can be just one click away when using the “notes urls” i OP5 Monitor. Combining these products will give you the possibility to actually have an updated documentation/inventory of all your hosts, that stays updated. The OP5 dokuwiki is already installed on your OP5 Monitor server so you can start use it at once.

## Integrating with OP5 Monitor

Integrating OP5 dokuwiki in OP5 Monitor means to configure the so called notes\_urls in Monitor to point to docuwiki. This way you can easily access your documentation/inventory from many of Monitor’s status-views by clicking the notes-icon next to the host name.

Integrating a single host or all your hosts to the dokuwiki in few steps.

1.  Edit one host notes\_url,  ’Configure’ -\> select a host -\> ‘Go’ -\> ‘Advanced’.
2.  In the ‘notes\_url’  field, press the button "Use wiki"
     ![](attachments/688639/5242979.png)
3.  Click the button ’Apply Changes’ if you only want to add a single host otherwise go on.
4.  Click the button  ’Propagate’ -\> check box for ‘notes\_url’ 
5.  Click the button ‘Propagate Selected Settings’ – \> Select the host you want to add from the list ‘Hostgroups’ or  ’Select hosts’ -\> ‘Go’
6.  Save and export your changes using ‘Save applied changes’ button.

## Test and start using

The host you edited should now have a folder-icon net to it’s host name in the status-views in Monitor (for example in the ‘Host Detail’-view). Clicking this icon will take you to the dokuwiki. Since there are no hosts documented yet, an empty page will appear. Now use the CREATE THIS PAGE link. The editor is loaded and a namespace-template for hosts is loaded. The namespace-template can be edited only at command line. Simply edit the file /var/www/html/docuwiki/data/pages/hosts/\_template.txt.

 

### [Download OP5 Monitor Free](https://www.op5.com/download-op5-monitor/)

[![](attachments/688465/16155433.png)](https://www.op5.com/download-op5-monitor/)

 

