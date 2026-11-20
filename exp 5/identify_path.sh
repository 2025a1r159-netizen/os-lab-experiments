#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file-or-directory>"
    exit 1
fi

path=$1

if [ -f "$path" ]; then
    echo "$path is a regular file."
elif [ -d "$path" ]; then
    echo "$path is a directory."
elif [ -e "$path" ]; then
    echo "$path exists, but it is not a regular file or directory."
else
    echo "$path does not exist."
fi
