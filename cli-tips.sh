#!/usr/bin/env bash

# shellcheck disable=SC2236

# Exit on any error
set -e

# Determine prefix
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
TIPS_FOLDER="${TIPS_FOLDER:-$prefix/share/cli-tips}"

SYSTEM_LANGUAGE="$(echo "$LANG" | cut -d'_' -f1)"

# Default language is based on the user's environment
LANGUAGE="${TIPS_LANGUAGE:-$SYSTEM_LANGUAGE}"

error() {
    echo "ERROR: $1"
    exit 1
}

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
    echo -e "\n"
    echo -e "\e[1mGitHub:\e[0m \e[0;30mhttps://github.com/cli-stuff/cli-tips\e[0m"
}

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
    -l | --language | --lang)
        if [[ -z "$2" ]]; then
            error "No language specified"
        fi
        LANGUAGE="$2"
        shift
        ;;
    --language=* | --lang=*)
        LANGUAGE="${1#*=}"
        ;;
    --about)
        if [[ -z "$2" ]]; then
            error "No keyword specified"
        fi
        KEYWORD="$2"
        shift
        ;;
    -h | --help)
        show_help
        exit 0
        ;;
    *)
        error "Unknown option: $1"
        ;;
    esac
    shift
done

# Check if the TIPS_FOLDER directory exists
if [ ! -d "$TIPS_FOLDER" ]; then
    error "Tips folder '$TIPS_FOLDER' does not exist."
fi

# Find the localized tips file
if [ -f "$TIPS_FOLDER/${LANGUAGE}.txt" ]; then
    localized_file="$TIPS_FOLDER/${LANGUAGE}.txt"
else
    echo "Language file '$TIPS_FOLDER/${LANGUAGE}.txt' does not exist. Using default language 'en'."
    localized_file="$TIPS_FOLDER/en.txt"
fi

# Read tips from the file into an array
if ! mapfile -t tips <"$localized_file"; then
    error "Failed to read tips from file '$localized_file'."
fi

# Filter tips based on the specified keyword
if [ -n "$KEYWORD" ]; then
    if ! filtered_tips=$(grep -i "$KEYWORD" <<<"${tips[@]}"); then
        error "Failed to filter tips with keyword '$KEYWORD'."
    fi
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
