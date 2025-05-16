#!/bin/bash

# Get the directory of this script
scripts_dir=$(dirname "$0")

# Run this script to test the Python version
# shellcheck disable=SC1091
. $scripts_dir/check_python_version.sh

