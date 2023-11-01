#!/bin/bash

# cacheIT! - v0.2
# Constantin CLERC

# This script makes a cache copy of any modification in the Printers directory
# Feel free to edit the monitored folder, as well as the cache folder (you can hide it more)

# 0.2 brings a rewrite as well as an app update selection system. Please update your sh script now by deleting current .cacheIT! hidden directory in your home folder.
# What's new ?
# Check for EVERY FILES AND FOLDERS, not only .app. This make file structure a lot more accurate and files are correctly copied.
# Update system - allow user to update apps (if app in cache is older than app in monitored)

# Path to the monitored folder
MONITORED_FOLDER="/Users/etudiant/Library/Printers/"

# Path to the cache folder
CACHE_FOLDER="/Users/etudiant/.cacheIT!/"

# Infinite loop to continuously monitor the folder
while true; do
    # Get a list of all files and folders in the monitored folder, including hidden ones
    current_items=$(find "$MONITORED_FOLDER" -mindepth 1)

    # Check for added or modified items
    for item in $current_items; do
        # Extract the relative path from the monitored folder
        relative_path=$(realpath --relative-to="$MONITORED_FOLDER" "$item")

        # Check if the item is not in the cache folder
        if [ ! -e "$CACHE_FOLDER/$relative_path" ]; then
            # Copy the item to the cache folder
            cp -R "$item" "$CACHE_FOLDER/$relative_path"
        elif [ -d "$item" ]; then
            # Check if the item in the cache folder is older than the monitored item
            if [ "$item" -nt "$CACHE_FOLDER/$relative_path" ]; then
                # Update the directory in the cache folder
                cp -R "$item" "$CACHE_FOLDER/$relative_path"
            fi
        else
            # Check if the item in the cache folder is older than the monitored item
            if [ "$item" -nt "$CACHE_FOLDER/$relative_path" ]; then
                # Update the file in the cache folder
                cp -R "$item" "$CACHE_FOLDER/$relative_path"
            fi
        fi
    done

    # Check for deleted items
    for cached_item in "$CACHE_FOLDER"/*; do
        # Extract the relative path from the cache folder
        relative_path=$(realpath --relative-to="$CACHE_FOLDER" "$cached_item")

        # Check if the cached item is not in the monitored folder
        if [ ! -e "$MONITORED_FOLDER/$relative_path" ]; then
            # Restore the item from the cache folder
            cp -R "$cached_item" "$MONITORED_FOLDER/$relative_path"
        fi
    done

    # Sleep for 30 seconds before the next check
    sleep 30
done
