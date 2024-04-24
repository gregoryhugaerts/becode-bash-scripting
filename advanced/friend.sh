#!/bin/bash

# Function to tell a random joke
tell_joke() {
    jokes_file="jokes.txt"
    if [ -f "$jokes_file" ]; then
        random_joke=$(shuf -n 1 "$jokes_file")
        echo "Here's a joke for you:"
        echo "$random_joke"
    else
        echo "Sorry, couldn't find the jokes file."
    fi
}

# Function to tell the current time
tell_time() {
    current_time=$(date +"%T")
    echo "The current time is: $current_time"
}

# Function to calculate simple equations
calculate() {
    result=$(echo "$1" | bc)
    echo "Result: $result"
}

# Interactive mode
interactive_mode() {
    echo "Welcome! How can I help you today?"
    while true; do
        read -p "You: " input
        case $input in
            "tell me a joke")
                tell_joke
                ;;
            "what's the time")
                tell_time
                ;;
            "exit"|"quit")
                echo "Goodbye!"
                break
                ;;
            *)
                if [[ $input == calculate* ]]; then
                    expression="${input#calculate }"
                    calculate "$expression"
                else
                    echo "Sorry, I didn't understand that."
                fi
                ;;
        esac
    done
}

# Non-interactive mode
non_interactive_mode() {
    case $1 in
        "joke")
            tell_joke
            ;;
        "time")
            tell_time
            ;;
        "calculate")
            calculate "$2"
            ;;
        *)
            echo "Invalid command."
            ;;
    esac
}

# Check if script is running in interactive mode
#if [ -t 0 ] || [ -p /dev/stdin ]; then
if [ "$#" -eq 0 ]; then
    interactive_mode
else
    non_interactive_mode "$@"
fi
