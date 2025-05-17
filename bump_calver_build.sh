#!/bin/bash

# Get the current date in "Year.Month.Day" format
current_date=$(date +"%Y.%m.%d")

# Get the current version using bump2version in Year.Month.Day format
current_version=$(bump2version --dry-run --list build | grep "current_version="  | sed -r 's/^.*=([0-9]{4}\.[0-9]{2}\.[0-9]{2}).*$/\1/')

# Compare the current date with the current version
if [ "$current_date" != "$current_version" ]; then
    # If they are not equal, set the new version with the build number to 0
    new_version="${current_date}.0"

    # Pass the new version to the --new-version option of bump2version
    bump2version --new-version $new_version --allow-dirty build
else
    # The current date and version are the same, autoincrement only build number
    bump2version --allow-dirty build
fi
