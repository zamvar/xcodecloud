#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

curl -sL https://firebase.tools | bash

FIREBASE_TOKEN = "1//0gXCXzXpN7hY9CgYIARAAGBASNwF-L9IrifLmAp_BW5KIP72Sjr5y5mopbrVQ-mrS1_Q5JNry0dmrjMGYUY94_PSROakoTLC9g-U"

# Function to upload to Firebase App Distribution
upload_to_firebase() {
    local file_path=$1
    local app_id=$2
    local release_notes=$3

    local git_messages
    git_messages=$(get_git_commit_messages)
    release_notes="${release_notes}\n\nRecent changes:\n${git_messages}"
    echo -e "${GREEN}$release_notes${NC}"

    echo -e "${GREEN}Uploading ${YELLOW}$FLAVOR${GREEN} build to Firebase project ID: ${YELLOW}$FIREBASE_PROJECT_ID${NC}"
    if ! firebase appdistribution:distribute $file_path --app $app_id --release-notes "$release_notes" --groups "ThinkBIT" --token $FIREBASE_TOKEN; then
        echo -e "${RED}Failed to upload $file_path to Firebase App Distribution.${NC}"

        read -p "Press any key to continue..."
        exit 1
    fi
}

APP_ID = "1:52233774317:ios:411d67e141bf5fbf09d8e4"
echo $CI_AD_HOC_SIGNED_APP_PATH
upload_to_firebase $CI_AD_HOC_SIGNED_APP_PATH $APP_ID "New $FLAVOR build for iOS"