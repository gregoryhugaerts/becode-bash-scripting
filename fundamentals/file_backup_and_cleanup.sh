#!/bin/bash

# Function to prompt user for directories to backup
prompt_directories() {
    directories=()
    while true; do
        read -p "Enter directory path to backup (leave blank to finish): " directory
        # expand the path (f.e. ~ would expand to the home folder)
        directory=$(eval echo "$directory")
        
        if [ -z "$directory" ]; then
            break
        fi
        if [ -d "$directory" ]; then
            directories+=("$directory")
        else
            echo "Invalid directory path. Please try again."
        fi
    done
}

# Function to confirm backup for each directory
confirm_backup() {
    read -p "Do you want to backup '$1'? (y/n): " response
    if [ "$response" = "y" ]; then
        return 0
    else
        return 1
    fi
}

# Function to backup a directory
backup_directory() {
    backup_filename=$(basename "$1").tar.gz
    tar -czf "$backup_filename" -C "$(dirname "$1")" "$(basename "$1")"
}

# Function to create backup directory if not exists
create_backup_directory() {
    backup_dir="backup"
    if [ ! -d "$backup_dir" ]; then
        mkdir "$backup_dir"
    fi
}

# Function to organize backup by date
organize_backup() {
    today=$(date +"%Y-%m-%d")
    backup_subdir="backup/$today"
    if [ ! -d "$backup_subdir" ]; then
        mkdir -p "$backup_subdir"
    fi
}

# Function to move archives to backup subdirectory
move_archives() {
    for archive in "$@"; do
        mv "$archive" "$backup_subdir"
    done
}

main() {
    echo "Welcome to the File Backup and Cleanup script!"

    # Prompt users for directories to backup
    prompt_directories

    # Confirm backup for each directory
    for directory in "${directories[@]}"; do
        if confirm_backup "$directory"; then
            backup_directory "$directory"
            echo "'$directory' has been backed up successfully."
        else
            echo "'$directory' skipped."
        fi
    done

    # Create backup directory if not exists
    create_backup_directory

    # Organize backup by date
    organize_backup

    # Move archives to backup subdirectory
    move_archives *.tar.gz
}

main
