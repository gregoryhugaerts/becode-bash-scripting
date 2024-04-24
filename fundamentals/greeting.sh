#!/bin/bash

hour=$(date +%H)
log_file="greeting.log"

# Function to greet based on time of day
greet() {
    if [ $hour -ge 5 ] && [ $hour -lt 12 ]; then
        echo "Good morning, $1!"
    elif [ $hour -ge 12 ] && [ $hour -lt 18 ]; then
        echo "Good afternoon, $1!"
    else
        echo "Good evening, $1!"
    fi

    # Log the username, time, and greeting to the file
    echo "$(date) - $1" >> "$log_file"
}

# Ask for the user's name
read -p "Enter your name: " name

greet "$name"
