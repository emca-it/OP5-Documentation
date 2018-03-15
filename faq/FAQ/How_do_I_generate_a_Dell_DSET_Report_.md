# How do I generate a Dell DSET Report?

## Question

* * * * *

How do I generate a Dell DSET Report?

## Answer

* * * * *

1.  Download the command line tool provided by Dell [here](https://download.op5.com/dell-dset-lx64-3.6.0.266.bin).
2.  Once downloaded, upload it to your op5 Monitor server by SFTP.
3.  Log on as root at your op5 Monitor server via SSH.
4.  Locate and identify the file name of the uploaded DSET tool, and then execute it by running the file through *bash*. An example can be seen below.

    ``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
    bash dell-dset-lx64-3.6.0.266.bin
    ```

5.  Read the license agreement. Scroll down by pressing the space key. At the bottom, you may agree by pressing *y*.
6.  Once the option menu has been displayed, press *2* for* Create a One-Time Local System DSET Report.*
7.  Follow the on-screen instructions (press Enter to accept default options) and then wait while the report is being generated.
8.  Once completed, the on-screen text will display the file name of the generated report (a zip file), and the directory it has been stored within. Download this file by SFTP, and send it to op5 Support for further analysis.

