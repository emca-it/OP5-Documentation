# I cannot login to Monitor and I get no error message

## Question

* * * * *

I cannot login to Monitor and I get no error message

## Answer

* * * * *

There can be several reasons for this, make sure you've tried the following:

1. Time problems. If the clock is out of sync at the server (or client) the browser might think that the login session is expired. When the session is expired you are redirected to the login prompt. Problems with time drifting is most common when using virtual machines. So verify that the clock on the server is set correctly.
2. Illegal chars in hostname. If you for example have underscore '\_' in the hostname login will fail on IE (session can not be created). Try to login using the ip-adress of the OP5 Monitor server and see if that helps.
