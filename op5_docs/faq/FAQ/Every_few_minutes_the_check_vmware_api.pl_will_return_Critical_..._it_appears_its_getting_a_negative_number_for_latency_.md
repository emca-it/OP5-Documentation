# Every few minutes, the check\_vmware\_api.pl will return Critical ... it appears its getting a negative number for latency?

## Question

* * * * *

Every few minutes, the check will return Critical … it appears its getting a negative number for latency:

CHECK\_VMWARE\_API.PL CRITICAL - io read latency=-1 ms | io\_read=-1ms;40;90
The same check will then return OK a few seconds later:
CHECK\_VMWARE\_API.PL OK - io read latency=0 ms | io\_read=0ms;40;90
Any idea why it might be getting a negative number?

## Answer

* * * * *

This problem can be fixed by collecting multiple samples of the data, described in the help text for the plugin:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
-M, --maxsamples=<max sample count> Maximum number of samples to retrieve. Max sample number is ignored for historic intervals. Default value is 1 (latest available sample).
```

## Comments:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td align="left"><p>This should be fully fixed in op5 Monitor 6.3: <a href="https://bugs.op5.com/view.php?id=4532#c18233">https://bugs.op5.com/view.php?id=4532#c18233</a></p>
<img src="images/icons/contenttypes/comment_16.png" /> Posted by peklof at Mar 24, 2014 09:40</td>
</tr>
</tbody>
</table>


