# Renew and Replace Certificate in ASA 5500

#### 1. Generate Certificate Signing request (CSR) and submit to CA
```
openssl req -new -key vpn.hydesquare.org.key -out vpn.request.csr
```
#### 2. Once you received the certificate, you need to export the new certificate from x.509 to PKCS12 archive (Only ASA can accept)
```
openssl pkcs12 -export -out example_com.p12 -inkey example_com.key -in example_com.crt -certfile AddTrustExternalCARoot.crt
```
#### 3. Add certificate via ADSM.
1. In ADSM, Click Configuration, Certificate Management then Identity Certificates.
2. Click Add, enter TrustpointName, Passphrase and .p12 file.

#### 4. Update interface with the new certificate.
1. Click Configuration, and then click Device Management.
2. Expand Advanced, and then expand SSL Settings.
3. Under Certificates, select the interface that is used to terminate WebVPN sessions. ...
4. Click Edit.
5. In the Certificate drop-down list, choose the certificate installed in Step 3.

## Resources
#### 1. Show certificates or trustpoints
```
sh cry ca cert
sh cry ca trustpoints
```
#### 2. Remove trustpoints
```
sh cry key zeroize RSA label ASDM_TrustPoint6
```
#### 3. http://www.cisco.com/c/en/us/support/docs/security/asa-5500-x-series-next-generation-firewalls/107956-renew-ssl.html
#### 4. http://www.cisco.com/c/en/us/support/docs/security/asa-5500-x-series-next-generation-firewalls/98596-asa-8-x-3rdpartyvendorcert.html