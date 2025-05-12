#!/bin/bash

python -V
if [ "$(python -V | awk 'NR==1{split($2, a, "."); print a[1]"."a[2]}')" != "$PYTHON_VERSION" ]; then
    echo Python version does not match v"$PYTHON_VERSION"
    exit 1
fi