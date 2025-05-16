#!/bin/bash



# Extract the Python version from the image tag
# Example: 3.12.2-slim -> 3.12
if [ -z "$IMAGE_TAG" ]; then
        echo "IMAGE_TAG is not set. Cannot extract PYTHON_VERSION."
        echo "Please set IMAGE_TAG to the tag of the image you are using."
        exit 0
else
    PYTHON_VERSION=$(echo ${IMAGE_TAG}| cut -d'-' -f1 | awk 'NR==1{split($1, a, "."); print a[1]"."a[2]}')
fi

python3 -V
if [ "$(python3 -V | awk 'NR==1{split($2, a, "."); print a[1]"."a[2]}')" != "$PYTHON_VERSION" ]; then
    printf "\n\033[0;31m✘ Python version does not match %s" "$PYTHON_VERSION"
    exit 1
fi