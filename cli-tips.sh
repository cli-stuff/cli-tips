#!/bin/bash

# Default tips folder
if [ ! -n "$TIPS_FOLDER" ]; then
    TIPS_FOLDER="/usr/share/cli-tips"
else
    TIPS_FOLDER="$TIPS_FOLDER"
fi

# Default language is based on the user's environment
if [ ! -n "$TIPS_LANGUAGE" ]; then
    LANGUAGE="$(echo $LANG | cut -d'_' -f1)"
else
    LANGUAGE="$TIPS_LANGUAGE"
fi

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -l|--language|--lang)
            LANGUAGE="$2"
            shift
            ;;
        --language=*|--lang=*)
            LANGUAGE="${1#*=}"
            ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Find the localized tips file
localized_file=$(find "$TIPS_FOLDER" -type f -name "tips_${LANGUAGE}.txt" | head -n 1)

# If a localized file is found, use it; otherwise, fall back to English
if [ -n "$localized_file" ]; then
    TIPS_FILE="$localized_file"
else
    TIPS_FILE="$TIPS_FOLDER/tips_en.txt"
fi

# Read tips from the file into an array
mapfile -t tips < "$TIPS_FILE"

# Generate random index
tip_index=$((RANDOM % ${#tips[@]}))

# Print random tip
echo "${tips[$tip_index]}"
