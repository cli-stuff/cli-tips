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
TIPS_LIST_FILE="$TIPS_FOLDER/tips.txt"

error() {
    echo "ERROR: $1" >&2
    exit 1
}

show_help() {
    echo -e "\e[1mUsage\e[0m: $(basename "$0") \e[1;34m[flags]\e[0m \e[1;32m[options]\e[0m"
    echo
    echo -e "\e[1mOptions\e[0m:"
    echo -e "  \e[1;34m-h, --help\e[0m   Show this help message and exit"
    echo -e "  \e[1;34m--about\e[0m      Specify a keyword to filter tips"
    echo
    echo -e "\e[1mExamples\e[0m:"
    echo -e "  $(basename "$0") \e[1;34m--about\e[0m git"
    echo
    echo -e "\e[1mGitHub\e[0m: https://github.com/cli-stuff/cli-tips\e[0m"
}

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
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

# Read tips from the file into an array
if ! mapfile -t tips <"$TIPS_LIST_FILE"; then
    error "Failed to read tips from file '$TIPS_LIST_FILE'."
fi

# Filter tips based on the specified keyword
if [ -n "$KEYWORD" ]; then
    filtered_tips=()

    for tip in "${tips[@]}"; do
        if [[ "$tip" =~ $KEYWORD ]]; then
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
