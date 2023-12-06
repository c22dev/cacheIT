#!/bin/bash
# cacheIT! - v0.3

# This script makes a cache copy of any modification in the Printers directory
# Feel free to edit the monitored folder, as well as the cache folder (you can hide it more)

# 0.3 just tars everything. More stable, no leftover.
# Path to the monitored folder


# Monitor folder path and cache folder path
folder_path="/Users/etudiant/Library/Printers/"
cache_path="/Users/etudiant/cacheIT/"

# Create the cache folder if it doesn't exist
mkdir -p "$cache_path"

# Initial state of the monitored folder
previous_state=$(find "$folder_path" -type f | sort)

# Function to create a new tar archive
create_tar() {
    # Create a timestamp for the tar filename
    timestamp="$(date +%Y%m%d%H%M%S)"

    # Create the tar archive with current timestamp
    tar -czf "$cache_path/archive_$timestamp.tar.gz" -C "$folder_path" .

    echo "Created new archive: archive_$timestamp.tar.gz"
}

# Function to restore deleted files
restore_files() {
    # Get the latest archive file
    latest_archive=$(ls -t "$cache_path" | grep -E "^archive_[0-9]{14}\.tar\.gz$" | head -1)

    # Extract the latest archive back to the folder path
    tar -xzf "$cache_path/$latest_archive" -C "$folder_path"

    echo "Restored files from $latest_archive"
}

# Initial creation of tar archive
create_tar

# Monitor the folder for changes
while :; do
    # Get the current state of the monitored folder
    current_state=$(find "$folder_path" -type f | sort)

    # Compare previous and current states
    if [[ "$previous_state" != "$current_state" ]]; then
        # Files added or modified
        create_tar
        previous_state="$current_state"
    else
        # Check if files were deleted
        diff_output=$(diff <(echo "$previous_state") <(echo "$current_state"))

        if [[ -n "$diff_output" ]]; then
            # Files deleted
            restore_files
            previous_state="$current_state"
        fi
    fi

    # Sleep for 1 second before checking again
    sleep 1
done
