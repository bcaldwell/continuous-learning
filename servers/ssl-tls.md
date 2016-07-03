# SSL/TLS

## WHY?

#### Benefits
- Encryption
- Authentication

#### Goal
- Trusted end-to-end communication

## Types of encryption
### Symmetric encryption
- 1 key is used to encrypt and decrypt the message
- **Problem:** encryption key needs to be shared

### Asymmetric encryption
- Rsa: public/private key method
- based on a key pair, 1 private key and 1 public key
- message is encrypted with the public key and can only be decrypted with the private key

## How does it work?

![how ssl works](pictures/ssl.gif)

1. Client requests a SSL/TLS connection ("client hello" message)
2. Server response with SSL certificate (which includes the public key) ("server hello" message)
3. Client validates the certificate/public key with a certification authority
4. Client generates a symmetric key (aka session key) and transmits it to the server
5. Server and client can now exchange messages that are symmetrically encrypted with the shared secret key

## Certification Authority (CA)

[source](https://www.lynda.com/SSL-tutorials/Understanding-Secure-Sockets-Layer/178124-2.html) 