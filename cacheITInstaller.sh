#!/bin/bash

# cacheIT Installer - v0.1
# Constantin CLERC

# This script installs cacheIT! and create the required directories. We'll use curl to prevent issues
# I suppose your home directory is named etudiant isn't it ?

# Create the cache directory (hidden ofc) and create parent directories if needed
mkdir -p /Users/etudiant/.cacheIT!/
echo "Attempt to create cacheIT! folder complete."
# We go in it
cd /Users/etudiant/.cacheIT!/
# Download the script file.
curl -O https://raw.githubusercontent.com/c22dev/cacheIT/main/cacheIT.sh
chmod +x cacheIT.sh
echo "cacheIT! script downloaded."

# Download the LaunchAgent file.
curl -O https://raw.githubusercontent.com/c22dev/cacheIT/main/live.cclerc.cacheitd.plist
echo "Script launcher at startup downloaded."
# Move it to launchAgents folder
mv -f /Users/etudiant/.cacheIT!/live.cclerc.cacheitd.plist ~/Library/LaunchAgents/
# Activate it !
launchctl load ~/Library/LaunchAgents/live.cclerc.cacheitd.plist
echo -e "Script launcher at startup installed.\n\n"

echo "cacheIT! is now installed on your computer ! Time to reboot it."