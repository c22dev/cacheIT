#!/bin/bash

# cacheIT! - v0.1
# Constantin CLERC

# This script make a cache copy of any modification in the Printers directory
# Feel free to edit the monitored folder, as well as the cache folder (you can hide it more)

# Path to the monitored folder
MONITORED_FOLDER="/Users/etudiant/Library/Printers/"

# Path to the cache folder
CACHE_FOLDER="/Users/etudiant/.cacheIT!/"
# Infinite loop to continuously monitor the folder
while true; do
    # Get a list of .app folders in the monitored folder
    current_apps=$(find "$MONITORED_FOLDER" -name "*.app" -type d)

    # Check for added .app folders
    for app_folder in $current_apps; do
        # Check if the app folder is not in the cache folder
        if [ ! -d "$CACHE_FOLDER/$(basename "$app_folder")" ]; then
            # Copy the app folder to the cache folder
            cp -r "$app_folder" "$CACHE_FOLDER"
        fi
    done

    # Check for deleted .app folders
    for cached_app_folder in "$CACHE_FOLDER"/*.app; do
        # Check if the cached app folder is not in the monitored folder
        if [ ! -d "$MONITORED_FOLDER/$(basename "$cached_app_folder")" ]; then
            # Copy the app folder back to the monitored folder
            cp -r "$cached_app_folder" "$MONITORED_FOLDER"
        fi
    done

    # Sleep for 30 seconds before the next check
    sleep 30
done
