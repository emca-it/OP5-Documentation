# NSClient: pdh collection thread not running On Windows Server 2003

## Question

* * * * *

NSClient: pdh collection thread not running On Windows Server 2003, 32-bit, with language pack installed it's not possible to check Uptime, Mem Usage and CPU Load. The checks result in the following state and error-message: UNKNOWN NSClient error: pdh

## Answer

* * * * *

The problem occurs because Windows Server 2003 tells NSClient++ that it's using the language in the language pack, but it doesn't respond to perfomance counters in that language. Confirmed workaround: replace all the counter definitions for the language in your language pack with the ones for US English in the file C:\\Program Files\\OP5\\op5\_NSClient++\\counters.defs. Leave the language code intact. Open up the file counters.defs. Copy the W2K counter lines in the english section ([0x0409]) and replace the W2K counter lines in the section for your language.
