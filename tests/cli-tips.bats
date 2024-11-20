#!/usr/bin/env bats

setup() {
    # Create a temporary directory for TIPS_FOLDER
    export TIPS_FOLDER="$(mktemp -d)"

    # Create sample tips files
    echo -e "Tip 1 in English\nTip 2 in English" >"$TIPS_FOLDER/en.txt"
    echo -e "Consejo 1 en Español\nConsejo 2 en Español" >"$TIPS_FOLDER/es.txt"

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

@test "Prints a tip in default language" {
    run "$SCRIPT_PATH"
    [ "$status" -eq 0 ]
    [[ "$output" == "Tip "* ]]
}

@test "Prints a tip in specified language" {
    run "$SCRIPT_PATH" --language es
    [ "$status" -eq 0 ]
    [[ "$output" == "Consejo "* ]]
}

@test "Filters tips with --about keyword" {
    # Add a tip containing the keyword 'git' to the English tips
    echo -e "Tip about git" >>"$TIPS_FOLDER/en.txt"

    run "$SCRIPT_PATH" --about git
    [ "$status" -eq 0 ]
    [[ "$output" == "Tip about git" ]]
}

@test "Filters tips with --about keyword and --language option" {
    # Add a tip containing the keyword 'git' to the English tips
    echo -e "Consejo sobre git" >>"$TIPS_FOLDER/es.txt"

    run "$SCRIPT_PATH" --about git --language es
    [ "$status" -eq 0 ]
    [[ "$output" == "Consejo sobre git" ]]
}

@test "Exits if no matching tips are found" {
    run "$SCRIPT_PATH" --about nonexistent
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "Uses default language if specified language file is missing" {
    rm "$TIPS_FOLDER/es.txt"
    run "$SCRIPT_PATH" --language es
    [ "$status" -eq 0 ]
    [[ "$output" == "Tip "* ]]
}

@test "Errors if no language is specified after --language option" {
    run "$SCRIPT_PATH" --language
    [ "$status" -ne 0 ]
    [[ "$output" == *"Error: No language specified"* ]]
}

@test "Handles missing TIPS_FOLDER gracefully" {
    rm -rf "$TIPS_FOLDER"
    run "$SCRIPT_PATH"
    [ "$status" -ne 0 ]
}

@test "Handles empty tips file gracefully" {
    echo -n "" >"$TIPS_FOLDER/en.txt"
    run "$SCRIPT_PATH"
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}
