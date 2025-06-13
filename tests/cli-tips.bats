#!/usr/bin/env bats

setup() {
    # Create a temporary directory for TIPS_FOLDER
    export TIPS_FOLDER="$(mktemp -d)"

    # Create sample tips files
    echo -e "Tip 1\nTip 2" >"$TIPS_FOLDER/tips.txt"

    # Path to the script being tested
    SCRIPT_PATH="./cli-tips.sh"
}

teardown() {
    # Remove the temporary TIPS_FOLDER
    rm -rf "$TIPS_FOLDER"
}

@test "Displays help with -h option" {
    run "$SCRIPT_PATH" -h
    [ "$status" -eq 0 ]
    [[ "$output" == *"Usage:"* ]]
}

@test "Displays help with --help option" {
    run "$SCRIPT_PATH" --help
    [ "$status" -eq 0 ]
    [[ "$output" == *"Usage:"* ]]
}

@test "Errors on unknown option" {
    run "$SCRIPT_PATH" --unknown
    [ "$status" -ne 0 ]
    [[ "$output" == *"Unknown option: --unknown"* ]]
}

@test "Filters tips with --about keyword" {
    # Add a tip containing the keyword 'git' to the English tips
    echo -e "Tip about git" >> "$TIPS_FOLDER/tips.txt"

    run "$SCRIPT_PATH" --about git
    [ "$status" -eq 0 ]
    [[ "$output" == "Tip about git" ]]
}

@test "Exits if no matching tips are found" {
    run "$SCRIPT_PATH" --about nonexistent
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}
