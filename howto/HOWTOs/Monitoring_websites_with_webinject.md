# Monitoring websites with webinject

## **Introduction**

Monitoring with WebInject is about testing a real-world scenario. If you measure web server response time simply by requesting / you might miss the delay when the database is doing a large select during the login process, and if you only monitor that the database server is up and running you might still miss the less common problems the web server might have while connecting to the database.

With WebInject, you can actually try out the entire login process, evaluate that the page doesn’t contain error messages or that the latest news show up. You can also measure the entire time it takes to log in – which on many sites can be as much as half a minute although the web server serves each page in just a couple of milliseconds.

## **Prerequisites**

There are a few things you need to be able to start working with WebInject

-   SSH access to your OP5 Monitor server
-   A web browser pointing at the page you will test
-   Basic Linux knowledge is preferred

In all examples and guides we assume you are logged in on the OP5 Monitor server by ssh and that you know how to handle a text editor in Linux.

 

 

## **How it works**

WebInject is a standalone application that performs tests and logs its results to the terminal, optionally writing a transcript of the session to disk. It may also be used as a plug-in to OP5 Monitor and this is what we are going to do in this how-to.

It takes two input files, both written in xml,

-   config file.
-   testcase file.

It returns its output on STDOUT – either in standalone mode when it will print an extensive report – or in plug-in mode when it will print a short format suitable for monitor

In OP5 Monitor you will find WebInject installed in:

 

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
/opt/plugins/webinject
.
|-- LICENSE
|-- README
|-- config.xml
|-- icon.gif
|-- logo.gif
|-- testcases
|`-- testcases.xml
`-- webinject.pl
```

## **The configuration files**

You may have as many configuration files as you like. But in this how-to we will stick to two files:

-   config.xml
-   devel-config.xml

There are a lot of things you may set in the configuration files but in this how-to we will only focus on the following settings:

**globalhttplog – [ yes | onfail ]**

Enables logging of HTTP requests/responses for all test cases. The HTTP requests sent and HTTP responses received are written to the http.log file

**globaltimeout**

The value [given in seconds] will be compared to the global time elapsed to run all the tests. If the tests have all been successful, but have taken more time than the ‘globaltimeout’ value, a warning message is sent back to op5 Monitor, Naemon or Nagios.

**reporttype – [ nagios | mrtg | external | standard ]**

This setting is used to enable output formatting that is compatible for use with specific external programs.
 **nagios** – Output of WebInject in console mode will be compatible for use as a plug-in for OP5 Monitor, Naemon or Nagios.
 **Standard** – Formatted output mode (omitting this setting defaults to ‘standard’ mode).

The following example shows how a config.xmlmight look like:

 

``` {.xml data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"}
<globalhttplog>onfail</globalhttplog>
<globaltimeout>10</globaltimeout>
<reporttype>nagios</reporttype>
```

 

**Creating the configuration files**

To create the configuration file config.xmlyou need to :

1.  Create the following file

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    /opt/plugins/webinject/config.xml
    ```

2.  Open up

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    /opt/plugins/webinject/config.xml
    ```

    in a text editor.

3.  Add the following data to config.xml:

     

    ``` {.xml data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"}
    <globalhttplog>onfail</globalhttplog>
    <globaltimeout>10</globaltimeout>
    <reporttype>nagios</reporttype>
    ```

4.  Save the file and exit the editor.

To create the configuration file devel-config.xmlyou need to :

1.  Create the following file

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    /opt/plugins/webinject/devel-config.xml
    ```

2.  Open up

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    /opt/plugins/webinject/devel-config.xml
    ```

    in a text editor.

3.  Add the following data to devel-config.xml:

     

    ``` {.xml data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"}
    <globalhttplog>yes</globalhttplog>
    <globaltimeout>20</globaltimeout>
    ```

4.  Save the file and exit the editor.

## **The test cases**

Test cases are written in XML files (using XML elements and attributes) and passed to the
WebInject engine for execution against the application/service under test.

A very simple example of a test case file may look like this:

``` {.xml data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"}
<testcases repeat="1">
<case
       id="1"
       url="http://myserver/test/test.html"
       verifyresponsecode="200"
       verifypositive="myserver"
       errormessage="Can not display the test page."
/>
</testcases>
```

 

The following list will explain the parts of the test case file:

    repeat="1"

Tells the WebInject engine how many times we shall execute the cases in this test case.

    id="1"

The id of the case and sets the order all cases will be executed.

    url="http://myserver/test/test.html"

The URL we will test this case against.

 

There are a lot of parameters you can use in a test case with WebInject but we will only use a few of them in this how-to.

The table below describes the parameters we will use in this how-to:

Parameter

Description

id

Test case identifier used to identify the test case and set it’s execution order

url

Full HTTP URL to request. You can use an IP Address or Host Name.

verifyresponsecode

HTTP response code for verification. Verification fails if the HTTP response code you specified does not match the HTTP response code you receive.

verifypositive

String in response for positive verification. Verification fails if this string does not exist in the HTTP response (including headers). This is matched as a Perl regular expression, so you can do some complex verification patterns if you are familar with using regex matching.

errormessage

If a test case fails, this custom ‘errormessage’ will be appended to the ‘TEST CASE FAILED’ line (on STDOUT and the HTML Report).

method

HTTP request method, can be “get” or “post”. This defaults to “get”

postbody

This is the data (body) of the request to be sent to the server. This is only used in an HTTP POST (method=”post”).

## **Creating a real example**

Now we shall create a real example where we will:

-   Test if we can display a login page (in this case our demo environment)
-   Test if we can authorize with the supplied username and password (can we actually authorize with the service) 
-   Test if we can get access with the supplied username and password (are we permitted to access the service)

To create the test case

-   Create a test case containing three cases that looks like this:
    /opt/plugins/webinject/testcases/test.xml

``` {.html/xml data-syntaxhighlighter-params="brush: html/xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: html/xml; gutter: false; theme: Confluence"}
<testcases repeat="1">
<case
        id="1"
        url="https://www.op5.com/wp-login.php"
        verifyresponsecode="200"
        verifypositive="Username"
        errormessage="Can not display the login page."
/>
<case
      id="2"
      method="post"
      url="https://www.op5.com/wp-login.php"
      postbody="log=op5testcentry@op5.com&pwd=Monitor03"
      verifyresponsecode="302"
      verifynegative="Authorization failed"
      errormessage="Login failed."
/>
<case
    id="3"
    method="post"
    url="https://www.op5.com/wp-login.php"
    postbody="log=op5testcentry@op5.com&pwd=Monitor03"
    verifyresponsecode="302"
    verifynegative="Denied access"
    errormessage="Denied access-error triggered."
/>
</testcases>
```

 

 

1.  Save the file:

        /opt/plugins/webinject/testcases/test.xml

     

2.  Test your test case like this (remember to use the devel-config.xmlfile)

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
/opt/plugins/webinject/webinject.pl -c devel-config.xml testcases/test.xml
```

The result should look something like this:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
Starting WebInject Engine...
-------------------------------------------------------
Test:  testcases/test.xml - 1 
Verify : "Username" 
Verify Response Code: "200" 
Passed Positive Verification 
Passed HTTP Response Code Verification 
TEST CASE PASSED 
Response Time = 0.123 sec 
------------------------------------------------------- 
Test:  testcases/test.xml - 2 
Verify Negative: "Authorization failed" 
Verify Response Code: "302" 
Passed Negative Verification 
Passed HTTP Response Code Verification 
TEST CASE PASSED 
Response Time = 0.045 sec 
------------------------------------------------------- 
Test:  testcases/test.xml - 3 
Verify Negative: "Denied access" 
Verify Response Code: "302" 
Passed Negative Verification 
Passed HTTP Response Code Verification 
TEST CASE PASSED 
Response Time = 0.045 sec 
------------------------------------------------------- 
    
Start Time: Wed Jun 26 12:42:12 2013
Total Run Time: 0.276 seconds
Test Cases Run: 3
Test Cases Passed: 3
Test Cases Failed: 0 
Verifications Passed: 6
Verifications Failed: 0
```

 

When you get a result without any failed cases you are ready to add the test to OP5 Monitor.

**Adding a WebInject service in OP5 Monitor**

To add a WebInject service to OP5 Monitor:

1.  Open up the host (www.example.org in this case) and chose “Add new service”.
2.  Set at least the following options:

Option

Value

service\_descriptions

Inject www.example.org

check\_command

check\_webinject

check\_command\_args

test.xml

1.  Click “Apply” and then “Save”.

## **More information**

WebInject can do a lot more than what we have seen here in this how-to. For more information about how to use the WebInject plug-in take a look at the official documentation:
 <http://webinject.org/manual.html>

# OP5 Monitor: Open Source Network Monitoring

[OP5 ](https://www.op5.com/)is the preferred Open Source Networking & Server Monitoring tool for large multi-national companies in over 60 markets. If you would like to experience OP5 Monitor you can get started here, alternatively, if you prefer to get more hands on you can Download OP5 Monitor for free. 

 

### [Download OP5 Monitor Free](https://www.op5.com/download-op5-monitor/)

[![](attachments/688465/16155433.png)](https://www.op5.com/download-op5-monitor/)

 

