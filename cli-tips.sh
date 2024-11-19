#!/usr/bin/env bash

# shellcheck disable=SC2236

# Exit on any error
set -e

if [[ ! -n "$PREFIX" ]]; then
    if echo "$OSTYPE" | grep -qE '^darwin.*'; then
        prefix="/usr/local"
    else
        prefix="/usr"
    fi
else
    prefix="$PREFIX"
fi

# Default tips folder
if [ ! -n "$TIPS_FOLDER" ]; then
    TIPS_FOLDER="$prefix/share/cli-tips"
fi

SYSTEM_LANGUAGE="$(echo "$LANG" | cut -d'_' -f1)"

# Default language is based on the user's environment
if [ ! -n "$TIPS_LANGUAGE" ]; then
    LANGUAGE="$SYSTEM_LANGUAGE"
else
    LANGUAGE="$TIPS_LANGUAGE"
fi

show_help() {
    echo -e "\e[1mUsage:\e[0m $(basename "$0") \e[1;34m[flags]\e[0m \e[1;32m[options]\e[0m"
    echo
    echo -e "\e[1mOptions:\e[0m"
    echo -e "  \e[1;34m-h, --help\e[0m                  Show this help message and exit"
    echo -e "  \e[1;34m-l, --lang, --language\e[0m      Specify the language for tips"
    echo -e "  \e[1;34m--about\e[0m                     Specify a keyword to filter tips"
    echo
    echo -e "\e[1mAvailable Languages:\e[0m"
    printf "  "
    for file in "$TIPS_FOLDER"/*.txt; do
        filename=$(basename "$file" .txt)
        echo -en "\e[1;32m$filename\e[0m "
    done
    echo -e "\n"
    echo -e "\e[1mExamples:\e[0m"
    echo -e "  $(basename "$0") \e[1;34m--language\e[0m en"
    echo -e "  $(basename "$0") \e[1;34m--language\e[0m es"
    echo -e "  $(basename "$0") \e[1;34m--about\e[0m git"
    echo
    echo
    echo -e "\e[1mGitHub:\e[0m \e[0;30mhttps://github.com/cli-stuff/cli-tips\e[0m"
}

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
    -l | --language | --lang)
        LANGUAGE="$2"
        if [[ ! -n "$LANGUAGE" ]]; then
            echo "Error: No language specified"
            exit 1
        fi
        shift
        ;;
    --language=* | --lang=*)
        LANGUAGE="${1#*=}"
        ;;
    --about)
        KEYWORD="$2"
        shift
        ;;
    -h | --help)
        show_help
        exit 0
        ;;
    *)
        echo "Unknown option: $1"
        exit 1
        ;;
    esac
    shift
done

if [[ ! -n "$LANGUAGE" ]]; then
    echo "Error: No language specified"
    exit 1
fi

# Find the localized tips file
if [ -f "$TIPS_FOLDER/${LANGUAGE}.txt" ]; then
    localized_file="$TIPS_FOLDER/${LANGUAGE}.txt"
else
    localized_file="$TIPS_FOLDER/en.txt"
fi

# Read tips from the file into an array
mapfile -t tips <"$localized_file"

# Filter tips based on the specified keyword
if [ -n "$KEYWORD" ]; then
    filtered_tips=()
    for tip in "${tips[@]}"; do
        if [[ "$tip" == *"$KEYWORD"* ]]; then
            filtered_tips+=("$tip")
        fi
    done
    tips=("${filtered_tips[@]}")
fi

# If there are no matching tips, exit
if [ ${#tips[@]} -eq 0 ]; then
    exit 0
fi

# Generate random index
tip_index=$((RANDOM % ${#tips[@]}))

# Print random tip
echo "${tips[$tip_index]}"
