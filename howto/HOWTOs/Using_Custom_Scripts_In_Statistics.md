# Using Custom Scripts In Statistics

This article is kept for historical purposes only. op5 Statisitcs is considered to be deprecated software

 

op5 Statistics comes with a lot of scripts as it is. But there are times when the pre-installed scripts just aren’t enough. This How-To will show you how to add your own script to op5 Statistics and how to create graphs with it. We will be using a simple script as an example and then create all templates needed to make it easy to use.

In this How-To we will be using a small Perl script that uses the op5 Monitor plugin called check\_http to graph the response time of a webserver. All commands in this How-To are executed in an ssh connection at the op5 Statistics server.

# Adding the script

First of all you have to place the script in the scripts directory on the op5 Statistics server. The script we are using here is called:

    check_http_responstime.sh

And it looks like this:

    #!/bin/bash
    /opt/plugins/check_http -H $1 | sed -n 's/[^=]*=([0-9.]*).*/1/p'

The script is executing the op5 Monitor plugin *check\_http* and using *sed* to get the responsetime in seconds. Put the script in */opt/statistics/scripts* on your op5 Statistics Server. Remember to make the script executable for all users with:

    chmod 755 /opt/statistics/scripts/check_http_responstime.sh

Test the script with the following command line:

    /opt/statistics/scripts/check_http_responstime.sh www.op5.com

The return data is response time in seconds.

# Adding new Data Input Method

First we have to configure op5 Statistics how to use the new script (check\_http\_responstime.sh) when collecting data. In the main menu in the configuration GUI of op5 Statistics you will find “Data Input Method” in the “Collection Method” section. Click on “Add” just above the listing of existing Data Input Methods. Fill in the following fields:

Data Input Methods

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">Name
Get HTTP Response Time</td>
<td align="left">Input Type
Choose: Script/Command</td>
</tr>
</tbody>
</table>

Click on the “create” button.

## Input and Output Fields

Now we have to add two type of fields:

Description of the fields

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">Input Fields
This is what we will use for the argument to the script</td>
<td align="left">Output Fields
This is the result returned by the script when executed during a poll</td>
</tr>
</tbody>
</table>

### Add Input Field

We start with the Input Field by clicking on “Add” at the right end of the Input Field listing, wich is supposed to be empty at the moment.

The Input Fields

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">Field [Input]
host</td>
<td align="left">Friendly Name
Hostname or IP address</td>
</tr>
</tbody>
</table>

Explanation:

-   **Field [Input]:** Here you will find the arguments added in the “Input String” when you started to create the Data Method.
-   **Friendly Name:** Just a small description of your Input Field.
-   **Regular Expression Match:** If you want to require a certain regular expression to be matched against input data, enter it here (ereg format). Not in use now.
-   **Allow Empty Input:** Checking this box will make it possible to use this script with an empty argument. Not in use now.
-   **Special Type Code:** Making op5 Statistics using the host name variable from the device that will use this later on instead of forcing you to enter one.

Click on the “create” button when you are done editing.

### Add Output Field

Now let’s add the Output Field.

The Output Fields

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">Field [Output]
responstime</td>
<td align="left">Friendly Name
Response time in seconds</td>
</tr>
</tbody>
</table>

Explanation

-   **Field [Output]:** The name of the output data that op5 Statistics receives from the script in a poll.
-   **Friendly Name:** Just a small description of your Output Field.
-   **Update RRD File:** Checking this make sure that the data from the script is stored in to the rrd file used by the graphs later on.

Click on the “create” button when you are done editing. Now just click on the “Save” button at the right bottom of the page and your Data Input Method “Get Response Time” is ready to use.

# Adding new Data Template

The data templates are used to build a so called skeleton that makes it easier to change a set of data sources that uses the same Data Template. It’s here you will define how the collected data is supposed to be used. Now we will continue with the creating of the “Data template”. In the main menu in the configuration GUI of op5 Statistics you will find “Data Templates” under the Templates section. Click on “Add” just above the listing of existing Data Templates. We now have three tables with fields to fill in.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">Name
Get HTTP Response time</td>
</tr>
</tbody>
</table>

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">Data Source
|host_description| – Get HTTP Respons Time</td>
<td align="left">Data Input Method
Choose Get HTTP Respons Time</td>
</tr>
</tbody>
</table>

Explanation

-   **Name:** |host\_description| is used so the host description will be used later on in the graphs. It makes sure the data source is distinguish for different devices.
-   **Data Input Method:** The Data Input Method used to collect the data.
-   **Associated RRA’s:** Round Robin Archives, which stores the data for a specific frequency in the RRD file
-   **Step:** Interval between pollings, in seconds
-   **Data Source Active:** If you un-check this the data source will be inactive and not in use.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">Internal Data Source Name
rt</td>
<td align="left">Minimum Value
0</td>
</tr>
</tbody>
</table>

Now when you have filled in all options as described above just click on the “Create” button.
 The “Data Source Item[] has now got a new line with a drop down list in it. As you only have one “Output Field” in the “Data Input Method” there is only one option here.

You will also get a new table at the bottom of the page. The table is called “Custom Data [data input: Get HTTP Response time]“. Just leave it as it is and click on the “Save” button.

# **Creating a new Graph Template**

All the settings in the Graph Template is used later on when op5 Statistics is creating the RRD file in witch the data for the graph is being saved.

## **Add the new Graph Template**

In the main menu in the configuration GUI of op5 Statistics you will find “Graph Templates” under the Templates section.
 Click on “Add” just above the listing of existing Data Templates.

In the new page you will find two tables. Most of the options are left with their default values. We only need to change these three options:

-   Name
-   Title
-   Vertical Label

The table below shows you the values of all the options on the first page.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">Name
Get HTTP Response Time</td>
</tr>
</tbody>
</table>

 

Graph Template

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">Title
|host_description| – Get HTTP Responstime</td>
<td align="left">Image Format
Choose png</td>
</tr>
</tbody>
</table>

Explanation:

-   **Image Format:** Choose what format the graph images are supposed to be in.
-   **Height:** The height of the graph images
-   **Width:** The width of the graph images
-   **Auto Scale:** Check this if you want the graph to be auto scaled.
-   **Auto Scale Options:** How the auto scale function is going to be used.
-   **Vertical Label:** The vertical label shown in the graph image.

After filling in the options click on the “Create” -button. After a successful creation of the Graph Template you will see a page with two new tables and the one you just saw.

# **Add Graph Items**

## **The line**

Now we will add the “Graph Items” that will be shown in the graphs using this “Graph Template”. To add a new “Graph Item” just click in “Add” in the “Graph Items” -table.

Graph Template Items

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">Data Source
Choose the Get HTTP Response time – (rt)</td>
<td align="left">Color
Choose what color you like</td>
</tr>
</tbody>
</table>

Click on the “Save” -button to save your new “Graph Item”.
 You will now see that you have “Data Source [rt]” listed in the “Graph Items Input”. Leave the “Data Source [rt]” as it is.

## **The Legends**

Now we want to have some nice legends in the graph images. So we will use a shortcut to create Maximum, Average and the Last value in one step.
 click in “Add” in the “Graph Items” -table again to create the legends.

Graph Template Items

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left">Data Source
Choose the Get HTTP Response time – (rt)</td>
<td align="left">Color
Choose what color you like</td>
</tr>
</tbody>
</table>

Click on the “Save” -button to save your new “Graph Item” which is actually three “Graph Items”.
 As you see now there is no new “Graph Items Input” because we are using the same for the Legends we just created.

Now when we are finished with the “Graph Template” we just click on the “Save” -button at the bottom of the page.

# **Create graphs**

The last thing to do is to start creating graphs that uses the templates described above.
 There are several ways to create graphs for a host. We will use one of them. Under the “Management” section in the main menu of op5 Statistics you will find “Devices”. Click on “Devices” to get a list of all devices added to op5 Statistics.
 In the top table you are able to filter out the type of devices you would like to see or search for a device name. Click on the device you would like to add a new graph to. First we need to associate the newly created “Graph Template” with the device. In the table “Associated Graph Templates” you will find a drop down list:
 Add Graph Template:

Choose the “Graph Template” we created (Get HTTP Response time) and click on the “Add” -button.

Now you will see that we have a associated graph template which is not being graphed yet. To start graphing click on “\*Create Graphs for this host” at the top of the page for this host. You will find a list of the graph templates associated with this host. The Grey outed ones are already in use.
 Check the unused one in the check-box to the right and click on the “Create” -button.

“+ Created graph: example.org – Get HTTP Response time” is displayed on the top of the page and you may click on “\*Edit this host” to go back to the host options again. Click on the “Save” -button and you are done with creating the graphs.

 

 

