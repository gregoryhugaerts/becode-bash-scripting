#!/bin/bash

# Check if a path is provided as a command-line argument
if [ $# -eq 1 ]; then
    directory="$1"
else
    # Prompt the user for the directory path
    read -p "Enter the directory path: " directory
    # expand the path (f.e. ~ would expand to the home folder)
    directory=$(eval echo "$directory")
fi

# Check if the specified path exists
if [ ! -d "$directory" ]; then
    echo "Error: The specified path does not exist."
    exit 1
fi

# Store the directory names and sizes in arrays
declare -A dir_sizes
declare -a sorted_dirs

# Loop through each directory in the specified path
for dir in "$directory"/*; do
    if [ -d "$dir" ]; then
        # Calculate the size of the directory
        size=$(du -sh "$dir" | cut -f1)

        # Store the directory size in the associative array
        dir_sizes["$(basename "$dir")"]="$size"
    fi
done

# Check if the associative array is empty
if [ ${#dir_sizes[@]} -eq 0 ]; then
    echo "No directories found in $directory"
    exit 0
fi

# Sort the directories by size
sorted_dirs=($(for dir in "${!dir_sizes[@]}"; do
    echo "$dir:${dir_sizes[$dir]}"
done | sort -rn -t: -k2 | cut -d: -f1))

# Output the sorted directories
for dir_name in "${sorted_dirs[@]}"; do
    echo "$dir_name: ${dir_sizes[$dir_name]}"
done
