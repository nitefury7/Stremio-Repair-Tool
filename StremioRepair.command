#!/bin/bash

# Configuration
APP_PATH="/Applications/Stremio.app"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Stremio Repair Tool for macOS${NC}"
echo "============================="

# Check if Stremio is installed
if [ ! -d "$APP_PATH" ]; then
    echo -e "${RED}Error: Stremio.app not found in /Applications folder.${NC}"
    echo "Please install Stremio first and do NOT open it before running this repair."
    read -p "Press [Enter] to exit..."
    exit 1
fi

echo "This tool will repair Stremio launch issues by:"
echo "1. Removing quarantine attributes"
echo "2. Cleaning hidden metadata files"
echo "3. Re-signing the application"
echo ""
echo -e "${YELLOW}Administrator privileges are required to repair the application.${NC}"
read -p "Press [Enter] to continue or Ctrl+C to cancel..."


echo ""
echo "Repairing Stremio..."

if sudo bash -c "
    xattr -cr '$APP_PATH' && \
    find '$APP_PATH' -name '._*' -delete && \
    find '$APP_PATH' -name '.DS_Store' -delete && \
    codesign --force --deep --sign - '$APP_PATH'
"; then
    echo ""
    echo -e "${GREEN}Success! Stremio has been fixed.${NC}"
    echo "You can now open it normally."
    read -p "Press [Enter] to exit..."
else
    echo ""
    echo -e "${RED}Repair failed. Please check the error messages above.${NC}"
    read -p "Press [Enter] to exit..."
    exit 1
fi
