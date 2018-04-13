# Add or renew an SSL certificate for OP5 Monitor

op5 Monitor is initially set up with a so called self-signed SSL certificate. Browsing a website that is using a self-signed SSL certificate will yield an SSL error message in the web browser, upon which you must accept the "invalid" certificate to access the website anyway.

To get rid of these error messages, the SSL certificate for your OP5 Monitor server must be properly set up, it must not have expired and it must have been signed by a trusted Certificate Authority (CA).

## **Prerequisites**

To be able to complete this how-to you will need:

- to have decided which CA you want to use to sign your certificate (just search the web for "ssl certificate" and you will find lots of options).
- to have set up a fully qualified domain name (FQDN) for your OP5 Monitor server (i.e. you access Monitor by a name resolvable in the DNS, not via the server's IP address).
- root command line access to the OP5 Monitor server (preferably via SSH).
- a web browser to verify the new certificate.

**If you already have a certificate ready to be installed, skip to *Start using your new certificate* below.**

## **Create a Certificate Signing Request (CSR)**

1. Log on to the OP5 Monitor server as root via SSH.

2. Begin creating a CSR based on the private key that is already installed, by executing the command below.
    `openssl req -new -key /etc/pki/tls/private/localhost.key -out ~/localhost.csr`
3. You will be asked a series of questions regarding the name and location of your organization. Fill out all the details, as many Certificate Authorities will reject your CSR if the fields are not properly filled out. All details should be valid, but should not contain sensitive information, since all details entered into this form can be viewed by anyone that is able to browse the OP5 Monitor web server.For example, the details can be entered like this:

    ``` {.text data-syntaxhighlighter-params="brush: text; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: text; gutter: false; theme: Confluence"}
    # openssl req -new -key /etc/pki/tls/private/localhost.key -out ~/localhost.csr
    Country Name (2 letter code) [GB]:SE
    State or Province Name (full name) [Berkshire]:Vastra Gotalands Lan
    Locality Name (eg, city) [Newbury]:Gothenburg
    Organization Name (eg, company) [My Company Ltd]:op5 AB
    Organizational Unit Name (eg, section) []:
    Common Name (eg, your name or your server's hostname) []:monitor.op5.com
    Email Address []:itadmin@op5.com

    Please enter the following 'extra' attributes
    to be sent with your certificate request
    A challenge password []:
    An optional company name []:
    ```

    It is very important to set the *Common Name* to the domain name used to browse your OP5 Monitor server. For instance, if you access OP5 Monitor by browsing to https://op5.your-company.com/ – then you should set the *Common Name* to op5.your-company.com.

## **Sign the request**

### Certificate Authority (CA) signing *(recommended)*

1. Download the* \~/localhost.csr* file from your OP5 Monitor server via SFTP.
2. Provide your Certificate Authority with the CSR file, and follow their instructions to get hold of a certificate file.

### Self-signing *(not recommended)*

In case you are just running a test environment for OP5 Monitor, you might not be interested in a certificate that is signed by a CA. Instead, you can create a self-signed certificate. However, as previously mentioned, please note that a self-signed certificate will always display SSL error messages in your web browser.

1. Log on to the OP5 Monitor server as root via SSH.

2. Execute the command below to create the self-signed certificate.
    `openssl x509 -req -days 365 -in ~/localhost.csr -signkey /etc/pki/tls/private/localhost.key -out ~/localhost.crt`This certificate will be signed for a year (365 days), but this can be changed by modifying the value of the *-days *argument in the command line above.

## **Start using your new certificate**

1. Once you have received your new certificate from your CA, upload the file to the OP5 Monitor server via SFTP. The new certificate should be named *localhost.crt* and should be put in root's home directory. *(Skip this step in case of using a self-signed certificate.)*
2. Log on to the OP5 Monitor server as root via SSH.

3. Create a backup of the old certificate by executing the command below.
    `cp -pv /etc/pki/tls/certs/localhost.crt{,.old}`
4. Install the new certificate:
    `cp -pv ~/localhost.crt /etc/pki/tls/certs/localhost.crt`
5. Restart the web server (Apache):`service httpd restart`
6. Access your OP5 Monitor server GUI using your web browser, and verify that no SSL error messages are seen. You should look both in the browser, from the client's point of view, and in the /var/log/httpd/ssl\_error\_log, from the server's point of view.
