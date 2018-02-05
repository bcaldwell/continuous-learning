# SSL/TLS

{:.no_toc}

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}


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
- RSA: public/private key method
- based on a key pair, 1 private key and 1 public key which are mathematically keyed to each other
- message is encrypted with the public key and can only be decrypted with the private key

## How does it work?

![how ssl works](../../pictures/ssl.gif)

1. Client requests a SSL/TLS connection ("client hello" message)
	- specifies the encryption standards that it can use. ex AES
	- sends a random number
2. Server response with SSL certificate (which includes the public key and signature) ("server hello" message)
	- confirms which encryption standard will be used
	- sends back random number encrypted with private key
	- client decodes the encrypted number with public key and compares 
3. Client validates the certificate/public key with a certification authority
4. Client generates a symmetric key (aka session key) and transmits it to the server (encrypted with the public key)
5. Server and client can now exchange messages that are symmetrically encrypted with the shared secret key
6. Encrypted Handshake: confirm that everything is working

## Certification Authority (CA)
- trusted third party that verifies the owner of the certificate
- included by browser or OS
	- can also just generated and installed on computers manually
- usually CAs will use an intermediate certificate to sign to protect the root CA

### Root CA
- are self signed
- can issue intermediate certificates like intermediate or leaf certificates

## Getting a certificate
1. Generate  self-signed certificate
2. Create a certificate signing request (CSR) using the self-signed certificate
3. CA will sign your certificate using their root/intermediate CA

## Certificates
- contains information about who you are
- contain the domain name and expiration date

## Signatures
- is calculated using the private key to encrypt a message and is sent along with the original message
- encrypted message will match the original message if and only if the sender has the private key
- RSA is the most common algorithm for this
- to reduce the size of the message we first has the message. The hash is the message that is sent and encrypted

#### Hashing

- a function that changes a message of any length into a string of the same length every time
- uniquely tied to the original message
- hashes must always result in a digest that is unique to the message
- the hash has safeguards to prevent duplication and undetected modification of the digest

[source](https://www.lynda.com/SSL-tutorials/Understanding-Secure-Sockets-Layer/178124-2.html) 