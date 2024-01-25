# pullcert
pullcert helps you pull certificates from web hosts

## Introduction
**pullcert** is a simple tool that pulls certificates from web hosts, relying on OpenSSL and Bash. Its main purpose is to take the difficulty out of this process and offer one of the following:
 - a human-readable parsed version of the certificate
 - an x509 representation of the certificate

It has been designed to be simple to use, easily incorporatable into your scripts and to stay out of your way.

## Usage
A quick example of getting certificate details with pullcert:
```shell
pullcert.sh -snioff thatstel.la
```

This produces an output like the following:
```
[*] pullcert 1.0
[*] https://github.com/ThatStella7922/pullcert

[Info] Will now retrieve the certificate for thatstel.la!
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            03:22:ac:96:e6:25:dc:37:86:6f:14:52:2c:5c:f9:5e:c1:89
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=US, O=Let's Encrypt, CN=R3
        Validity
            Not Before: Jan  8 20:12:07 2024 GMT
            Not After : Apr  7 20:12:06 2024 GMT
        Subject: CN=thatstel.la
        Subject Public Key Info:
            [truncated for brevity]
```

For more advanced usage including SNI, x509 representation and more, see the full usage details below.

<details>
<summary>pullcert's full usage details</summary>

This help is produced when running `pullcert.sh` with the `-h` argument (or no argument).

```
[*] pullcert 1.0
[*] https://github.com/ThatStella7922/pullcert

[?] pullcert helps you pull certificates from web hosts
[?]
[?] Basic usage example:
[?]  pullcert.sh -snioff thatstel.la
[?]
[?] All possible arguments:
[?]  pullcert.sh [sni arg] [host] [hostname if SNI] [raw]
[?]
[?] Documentation:
[?] -h or --h    Show this help.
[?]
[?] SNI argument
[?] SNI is when multiple SSL hosts are sharing a single IP address.
[?] -snion       Enables SNI support
[?] -snioff      Disables SNI support
[?]
[?] Host argument
[?] This argument should be the host you want to pull the certificate from.
[!] Do not specify the protocol (such as https://), just the host.
[!] Cannot be a subpage like thatstel.la/example, if you want to pull the
[!] certificate for a subpage, enable SNI and use the hostname argument.
[?]
[?] Hostname argument (only needed if SNI is enabled)
[?] This argument lets you specify the correct hostname for the certificate
[?] in the case of the remote server using SNI.
[!] Do not specify the protocol (such as https://), just the hostname.
[!] If you are trying to pull the certificate for a subpage, enable SNI and
[!] pass your subpage address like below:
[!]  pullcert.sh -snion thatstel.la thatstel.la/example
[?]
[?] Raw argument
[?] Retrieves the raw x509 certificate instead of the human-readable data.
[?] To use this argument, simply pass 'raw' as the last argument like below:
[?]  pullcert.sh -snioff thatstel.la raw
[?]  pullcert.sh -snion thatstel.la thatstel.la/example raw
[?]
[?] Silent mode
[?] Will disable all pullcert output except for the raw x509 certificate.
[?] To use it, pass '-silent' as the very first argument. You do not need to
[?] pass the raw argument when using silent mode. Example:
[?]  pullcert.sh -silent -snion thatstel.la thatstel.la/example
```


</details>

## Requirements and Compatibility
**pullcert** requires Bash and OpenSSL with s_client support, and should run on any OS that can provide these dependencies.
