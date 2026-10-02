#!/bin/bash

# RunBoy Deployment Script
# This script automates the build and archive process for App Store submission

set -e

echo "🎮 RunBoy App Store Deployment Script"
echo "======================================"

# Check if xcodebuild is available
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Error: Xcode command line tools not found."
    echo "   Install with: xcode-select --install"
    exit 1
fi

echo "✓ Xcode tools found"

# Get bundle ID from user
read -p "Enter your Bundle ID (e.g., com.yourname.runboy): " BUNDLE_ID

if [ -z "$BUNDLE_ID" ]; then
    echo "❌ Bundle ID cannot be empty"
    exit 1
fi

echo "✓ Bundle ID: $BUNDLE_ID"

# Get team ID from user
read -p "Enter your Team ID (from Apple Developer): " TEAM_ID

if [ -z "$TEAM_ID" ]; then
    echo "❌ Team ID cannot be empty"
    exit 1
fi

echo "✓ Team ID: $TEAM_ID"

# Build and archive
echo ""
echo "Building RunBoy for App Store..."

xcodebuild -scheme RunBoyApp \
    -configuration Release \
    -derivedDataPath ./build \
    -archivePath ./build/RunBoy.xcarchive \
    -archivePathForTeamID "$TEAM_ID" \
    archive

echo ""
echo "✓ Archive created: ./build/RunBoy.xcarchive"
echo ""
echo "Next steps:"
echo "1. Open Xcode Organizer: Xcode > Window > Organizer"
echo "2. Select the RunBoy archive"
echo "3. Click 'Distribute App'"
echo "4. Follow the prompts to submit to App Store Connect"
echo ""
echo "For detailed instructions, see DEPLOY_GUIDE.md"
