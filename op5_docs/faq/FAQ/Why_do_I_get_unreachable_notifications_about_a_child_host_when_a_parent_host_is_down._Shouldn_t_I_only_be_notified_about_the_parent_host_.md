# Why do I get unreachable notifications about a child host when a parent host is down. Shouldn't I only be notified about the parent host?

## Question

* * * * *

Why do I get unreachable notifications about a child host when a parent host is down. Shouldn't I only be notified about the parent host?

## Answer

* * * * *

When op5 Monitor realize that a child host is down it will test if the parent host is down. If the parent host is down op5 Monitor will set the childhost to unreachable state. The notifications sent out later on will be: 

1.  Parent host: down 
2.  Child host: unreachable 

To avoid notifications about unreachable hosts you should change either the contact, host or host template. Contact: Make sure unreachable is unchecked in host\_notification\_options Host / Host template: Make sure unreachable is unchecked in notification\_options

 

