#!/bin/bash

# Path to the generated.xcconfig file
CONFIG_FILE="../Flutter/Generated.xcconfig"

# Check if the SCHEME environment variable is set
if [ -z "$CI_XCODE_SCHEME" ]; then
    echo "Error: No scheme (flavor) provided!"
    exit 1
fi

# Convert the scheme to lowercase
FLAVOR=$(echo "$CI_XCODE_SCHEME" | tr '[:upper:]' '[:lower:]')

# Construct the new FLUTTER_TARGET based on the flavor
NEW_FLUTTER_TARGET="lib/main_${FLAVOR}.dart"

# Check if the generated.xcconfig file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: File $CONFIG_FILE not found!"
    exit 1
fi

# Use sed to update FLUTTER_TARGET
sed -i '' "s|^FLUTTER_TARGET=.*|FLUTTER_TARGET=$NEW_FLUTTER_TARGET|" "$CONFIG_FILE"

# Output result
echo "FLUTTER_TARGET updated to $NEW_FLUTTER_TARGET in $CONFIG_FILE"