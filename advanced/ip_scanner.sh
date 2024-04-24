#!/bin/bash

# Function to perform whois lookup
whois_lookup() {
    echo "WHOIS Lookup:"
    whois "$1" | grep -E 'netname:|descr:|country:|role:|abuse-mailbox:'
    echo
}

# Function to perform reverse DNS lookup
reverse_dns_lookup() {
    echo "Reverse DNS Lookup:"
    host "$1"
    echo
}

# Function to perform HTTP query
http_query() {
    echo "HTTP Query:"
    curl -Is "http://$1" | head -n 1
    echo
}

# Function to perform HTTPS query
https_query() {
    echo "HTTPS Query:"
    curl -Is "https://$1" | head -n 1
    echo
}

# Function to perform geolocation
geolocation() {
    echo "Geolocation:"
    curl -s "https://ipinfo.io/$1/json" | jq '.city, .region, .country'
    echo
}

# Main function
main() {
    IP="$1"
    whois_lookup "$IP"
    reverse_dns_lookup "$IP"
    http_query "$IP"
    https_query "$IP"
    geolocation "$IP"
}

# Input IP address from user
read -p "Enter IP address: " IP_ADDRESS

# Call main function with user-input IP address
main "$IP_ADDRESS"
