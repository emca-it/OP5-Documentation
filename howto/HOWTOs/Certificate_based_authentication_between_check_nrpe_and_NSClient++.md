# Certificate based authentication between check\_nrpe and NSClient++

Version

This article was written for version 0.4.4 of NSClient++. Versions 0.3.x and earlier of NSClient++ did not rely on the Windows Registry as heavily, so these notes would not apply. These instructions should work on later versions unless otherwise noted.

Articles in the Community-Space are not supported by OP5 Support.

If you already followed the HOWTO [Certificate based TLSv1+ encryption with NSClient++](Certificate_based_TLSv1+_encryption_with_NSClient++), adding a further security step (certificate authentication) is a breeze.

Equivalent setup is possible with NRPE \>= 3.0.x instead of NSClient++ on the monitored host side.

With this there's 3 options of certificate authentication.

1. Authenticate the OP5 Monitor client (check\_nrpe) - **verify mode - peer-client** with NSClient++
2. Authenticate the monitored host  (NSClient++) -  **-A /path/to/my\_CA\_cert.pem **with check\_nrpe
3. Authenticate both ways

## Requisites

- NSClient++ 0.4.x or newer
- check\_nrpe 3.0.x or newer
- CA certificate and client certificates generated based on this CA (see [Create a self-signed CA & client certificate with OpenSSL](Create_a_self-signed_CA_client_certificate_with_OpenSSL))

## NSClient++

Since the monitored host with NSClient++ is the server in the relationship with check\_nrpe, we wan't to verify the client before we reveal our inner secrets (checks and performance data).
In the encryption HOWTO I mentioned using a CA certificate which will come in handy now, because now It's only 1 option change in NSClient++ to add certificate authentication.

To activate verification (certificate authentication) of the client (check\_nrpe) all we need to do is change **verify mode** option in NSClient++.

This setting is located at **/settings/NRPE/server **within NSClient++ settings structure. Registry path: **[HKEY\_LOCAL\_MACHINE\\SOFTWARE\\NSClient++\\settings\\NRPE\\server]**

Settings name

Recommended value

Default value

verify mode

peer-cert

none

Simple explanation of the option:

verify mode - Comma separated list of verification flags to set on the SSL socket.
                      **none** - No verification is made
                      **peer **- NSClient++ sends client certificate request to the client (check\_nrpe) and the certificate returned (if any) is checked against CA certificate.
                      **fail-if-no-cert** - Terminate the SSL handshake if no client certificate is returned
                      **peer-cert** - Alias for peer + fail-if-no-cert

Since we're using peer-cert we're both require the return of a client certificate and we verify that it's valid against the CA certificate.

check\_nrpe

In the other HOWTO about encryption, we didn't need to specify anything regarding encryption with check\_nrpe. Now we have the possibility to both present our own client certificate so NSClient++ will accept us (verify mode - peer-cert), but also to verify the host / NSClient++  if we like, so a 2-way authentication.

First of all, because of the change within NSClient++ settings above, the following option flags are required with check\_nrpe to be able to establish communication to the monitored host (NSClient++).

./check\_nrpe\_v3 -H HOSTNAME/IP -C /path/to/my\_client\_cert.pem -K /path/to/my\_client\_key.key -c CheckCPU -a ShowAll=long MaxWarn=80% MaxCrit=90%

This requires that you've generated a certificate for your OP5 Monitor server, running this check, and with -C & -K you're telling check\_nrpe where your client certificate with private key are.

Now when you do a check against the host, NSClient++ will request a client certificate from check\_nrpe, which we give, and then NSClient++ will verify it against it's CA certificate that we specified in the other [HOWTO](Create_a_self-signed_CA_client_certificate_with_OpenSSL).

To take this one step further, we can verify the certificate on the host with NSClient++ as well when doing a check\_nrpe request. This requires that the CA certificate is available on the OP5 Monitor server as well, and we add one more options flag to the check\_nrpe command.

./check\_nrpe\_v3 -H HOSTNAME/IP -A /path/to/my\_CA\_cert.pem -C /path/to/my\_client\_cert.pem -K /path/to/my\_client\_key.key -c CheckCPU -a ShowAll=long MaxWarn=80% MaxCrit=90%

This will be the equivalent of **verify mode** option **peer-cert** in NSClient++, if the client certificate & key from NSClient++ doesn't match the CA certificate, the handshake fails and connection is dropped.
