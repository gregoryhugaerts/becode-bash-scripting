#!/bin/bash

# File to store the last recorded public IP
LOG_FILE="public_ip.log"

# Function to retrieve the current public IP address using ipify.org
get_public_ip() {
    curl -s https://api.ipify.org
}

# Function to check if IP has changed
check_ip_change() {
    current_ip=$(get_public_ip)
    if [ -f "$LOG_FILE" ]; then
        last_ip=$(tail -n 1 "$LOG_FILE")
        if [ "$current_ip" != "$last_ip" ]; then
            echo "$(date): Public IP changed from $last_ip to $current_ip"
            echo "$current_ip" >> "$LOG_FILE"
            # Add notification mechanism here (e.g., email, desktop notification)
            # For simplicity, let's just echo a notification
            echo "Public IP changed from $last_ip to $current_ip"
        fi
    else
        echo "$(date): Initial public IP recorded: $current_ip"
        echo "$current_ip" > "$LOG_FILE"
    fi
}

# Check IP change and log it
check_ip_change

