# Writeprotected configuration files

# About

By making a file write-protected it cannot be changed by op5 Configuration. This is equivalent to the naemon function called **notouch.**

**Table of Content**

-   [About](#Writeprotectedconfigurationfiles-About)
-   [Writing the file ](#Writeprotectedconfigurationfiles-Writingthefile)

<!-- -->

     

     

# Writing the file 

Create the file `/opt/monitor/op5/nacoma/custom_config.php`

Add the following content:

``` {.php data-syntaxhighlighter-params="brush: php; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: php; gutter: false; theme: Confluence"}
<?php
$notouch_file_prefix = 'static_';
?>
```

If a configuration file in is renamed with the `static_ `prefix op5 configuration will not be able to change this file.

 

 

 

 

