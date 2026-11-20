#!/bin/bash

if [ "$#" -lt 3 ]; then
    echo "Usage:"
    echo "  $0 rename <source> <destination>"
    echo "  $0 copy <source> <destination>"
    echo "  $0 ext <filename> <new-extension>"
    exit 1
fi

operation=$1
source=$2
destination=$3

case "$operation" in
    rename)
        if [ ! -f "$source" ]; then
            echo "Error: source file '$source' does not exist."
            exit 1
        fi
        if [ -e "$destination" ]; then
            echo "Error: destination '$destination' already exists."
            exit 1
        fi
        mv -- "$source" "$destination" && echo "File renamed to '$destination'."
        ;;
    copy)
        if [ ! -f "$source" ]; then
            echo "Error: source file '$source' does not exist."
            exit 1
        fi
        if [ -e "$destination" ]; then
            echo "Error: destination '$destination' already exists."
            exit 1
        fi
        cp -- "$source" "$destination" && echo "File copied to '$destination'."
        ;;
    ext)
        if [ ! -f "$source" ]; then
            echo "Error: file '$source' does not exist."
            exit 1
        fi
        new_extension=${destination#.}
        if [ -z "$new_extension" ]; then
            echo "Error: provide a new extension, such as md or txt."
            exit 1
        fi
        filename=${source##*/}
        if [[ "$filename" == *.* && "$filename" != .* ]]; then
            basename=${filename%.*}
        else
            basename=$filename
        fi
        target="${source%/*}/"
        if [ "$target" = "$source/" ]; then
            target=""
        fi
        target="${target}${basename}.${new_extension}"
        if [ -e "$target" ]; then
            echo "Error: destination '$target' already exists."
            exit 1
        fi
        mv -- "$source" "$target" && echo "Extension changed: '$source' -> '$target'."
        ;;
    *)
        echo "Unknown operation: $operation"
        echo "Choose: rename, copy, or ext"
        exit 1
        ;;
esac
