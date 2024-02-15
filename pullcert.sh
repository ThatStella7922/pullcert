#!/bin/bash

ver="1.1"

# colors
usecolors="true"
reset="\033[0m";faint="\033[37m";red="\033[38;5;196m";black="\033[38;5;244m";green="\033[38;5;46m";yellow="\033[38;5;226m";magenta="\033[35m";blue="\033[36m";default="\033[39m"
# formatting
bold="\033[1m";resetbold="\033[21m"
# message styling
init="${black}${faint}[${reset}${magenta}*${reset}${black}${faint}]${reset}"
info="${black}${faint}[${reset}${green}Info${reset}${black}${faint}]${reset}"
question="${black}${faint}[${reset}${yellow}?${reset}${black}${faint}]${reset}"
help="${black}${faint}[${reset}${green}?${reset}${black}${faint}]${reset}"
error="${black}${faint}[${reset}${red}${bold}Error${reset}${resetbold}${black}${faint}]${reset}"
warn="${black}${faint}[${reset}${yellow}!${reset}${black}${faint}]${reset}"
azule="${black}${faint}[${reset}${blue}Azule${reset}${black}${faint}]${reset}"
success="${black}${faint}[${reset}${green}√${reset}${black}${faint}]${reset}"
if [[ $usecolors == "false" ]]; then
    reset="";faint="";red="";black="";green="";yellow="";magenta="";blue="";default=""
fi

showHelp () {
    echo -e "$help pullcert helps you pull certificates from web hosts"
    echo -e "$help"
    echo -e "$help Basic example:"
    echo -e "$help  pullcert.sh -snioff thatstel.la"
    echo -e "$help"
    echo -e "$help Valid arguments:"
    echo -e "$help  pullcert.sh [sni arg] [host] [hostname if SNI] [raw]"
    echo -e "$help"
    echo -e "$help Full documentation:"
    echo -e "$help -h or --h    Show this help."
    echo -e "$help -v or --v    Print the version and exit"
    echo -e "$help"
    echo -e "$help SNI argument"
    echo -e "$help SNI is when multiple SSL hosts are sharing a single IP address."
    echo -e "$help -snion       Enables SNI support"
    echo -e "$help -snioff      Disables SNI support"
    echo -e "$help"
    echo -e "$help Host argument"
    echo -e "$help This argument should be the host you want to pull the certificate from."
    echo -e "$warn Do not specify the protocol (such as https://), just the host."
    echo -e "$warn Cannot be a subpage like thatstel.la/example, if you want to pull the"
    echo -e "$warn certificate for a subpage, enable SNI and use the hostname argument."
    echo -e "$help" 
    echo -e "$help Hostname argument (only needed if SNI is enabled)"
    echo -e "$help This argument lets you specify the correct hostname for the certificate"
    echo -e "$help in the case of the remote server using SNI."
    echo -e "$warn Do not specify the protocol (such as https://), just the hostname."
    echo -e "$warn If you are trying to pull the certificate for a subpage, enable SNI and"
    echo -e "$warn pass your subpage address like below:"
    echo -e "$warn  pullcert.sh -snion thatstel.la thatstel.la/example"
    echo -e "$help" 
    echo -e "$help Raw argument" 
    echo -e "$help Retrieves the raw x509 certificate instead of the human-readable data."
    echo -e "$help To use this argument, simply pass 'raw' as the last argument like below:"  
    echo -e "$help  pullcert.sh -snioff thatstel.la raw"  
    echo -e "$help  pullcert.sh -snion thatstel.la thatstel.la/example raw"
    echo -e "$help" 
    echo -e "$help Silent mode"
    echo -e "$help Will disable all pullcert output except for the raw x509 certificate."
    echo -e "$help To use it, pass '-silent' as the very first argument. You do not need to"
    echo -e "$help pass the raw argument when using silent mode. Example:"
    echo -e "$help  pullcert.sh -silent -snion thatstel.la thatstel.la/example" 
}

printInit() {
    echo -e "$init pullcert $ver"
    echo -e "$init https://github.com/ThatStella7922/pullcert"
}

# Call: getCert sni[-snioff/-snion] host hostname raw
#
#                                          raw
#                                      if SNI is off
getCert () {
    if [[ $1 == "-snion" ]]; then
        if [[ $4 == "raw" ]]; then
            getCertRaw $1 $2 $3
            exit 0
        fi
        echo -e "$info Will now retrieve the certificate for $2 with hostname $3!"
        echo | openssl s_client -connect $2:443 -servername $3 | openssl x509 -noout -text 2>/dev/null
    elif [[ $1 == "-snioff" ]]; then
        if [[ $3 == "raw" ]]; then
            getCertRaw $1 $2
            exit 0
        fi
        echo -e "$info Will now retrieve the certificate for $2!"
        echo | openssl s_client -connect $2:443 | openssl x509 -noout -text 2>/dev/null
    else
        exit 1
    fi
}

# Call: getCertRaw sni[-snioff/-snion] host hostname raw
#
#                                             raw
#                                         if SNI is off
getCertRaw () {
    if [[ $1 == "-snion" ]]; then
        echo -e "$info Will now retrieve the raw certificate for $2 with hostname $3!"
        echo | openssl s_client -connect $2:443 -servername $3 2>/dev/null | openssl x509 2>/dev/null
        exit 0
    elif [[ $1 == "-snioff" ]]; then
        echo -e "$info Will now retrieve the raw certificate for $2!"
        echo | openssl s_client -connect $2:443 2>/dev/null | openssl x509 2>/dev/null
        exit 0
    else
        echo -e "$error Invalid SNI argument"
        exit 1
    fi
}

# Call: getCertRawSilent sni[-snioff/-snion] host hostname raw
#
#                                             raw
#                                         if SNI is off
getCertRawSilent () {
    if [[ $1 == "-snion" ]]; then
        echo | openssl s_client -connect $2:443 -servername $3 2>/dev/null | openssl x509 2>/dev/null
        exit 0
    elif [[ $1 == "-snioff" ]]; then
        echo | openssl s_client -connect $2:443 2>/dev/null | openssl x509 2>/dev/null
        exit 0
    else
        echo -e "$error Invalid SNI argument"
        exit 1
    fi
}

### End of function declarations
### pullcert starts here

if [[ $1 == "-silent" ]]; then
    getCertRawSilent $2 $3 $4 $5 
fi # Detect if silent argument is provided, if yes run the getCertRawSilent function (this function exits for us)

if [[ $1 == "-v" ]] || [[ $1 == "--v"* ]]; then
    printInit
    exit 0
fi # Detect if version argument is provided, if yes run the version function and exit

printInit # prints the version info and stuff, running normally without intercepting silent or version
echo

# if first argument is empty, show help
# if [[ -z $1 ]] || [[ -z $2 ]] || [[ -z $3 ]]; then
if [[ -z $1 ]]; then
    showHelp
    exit 1
fi

# if argument one is help, show help
if [[ $1 == "-h" ]] || [[ $1 == "--h"* ]]; then
    showHelp
    exit 0
else
    if [[ -z $2 ]]; then
        echo -e "$error No host specified. (Did you forget to pass the SNI argument?)"
        exit 1
    fi
    if [[ -z $3 ]] && [[ $1 == "-snion" ]]; then
        echo -e "$error No hostname specified, but is required (SNI support is enabled)"
        exit 1
    fi

    getCert $1 $2 $3 $4

fi