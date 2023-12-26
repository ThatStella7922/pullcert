# pullcert

pullcert helps you pull certificates from web hosts

## Usage

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