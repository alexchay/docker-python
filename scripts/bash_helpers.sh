#!/usr/bin/env bash

DEFAULT_IMAGE_TAG=3.9-slim

# Extract ref name from git current branch/tag
function extract_ref_name {

    local ref_name=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/HEAD detached at //' -e 's/* (\(.*\))/\1/' -e 's/* \(.*\)/\1/');

    # Check if the tag is empty
    if [ -z "$ref_name" ]; then
        printf "\033[0;31m✘\033[0m Error: Failed to ref_name from: \n%s\n" "$(git branch)"
        return 1
    fi

    echo "$ref_name"
}

# Get image tag
function get_image_tag {

    local ref_name=$(extract_ref_name)

    # If the ref_name starts with '3', use it as the image tag
    if [[ "$ref_name" == 3* ]]; then
        echo "$ref_name";
    else
        echo "$DEFAULT_IMAGE_TAG";
    fi
}

function help {

    printf "Usage: %s <task> [args]\n\nAvailable tasks:\n" "$(basename "${0}")"

    # List all functions in the script, excluding internal ones (starting with '_')
    compgen -A function | grep -v "^_" | cat -n
    printf "\nExtended help:\n  Each task has comments for general usage\n"
}

# Run the specified task or show help if no task is provided
"${@:-help}"