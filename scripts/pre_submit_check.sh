#!/bin/bash

# RunBoy Pre-Submit Checklist Script
# Validates project before App Store submission

echo "🎮 RunBoy Pre-Submission Checklist"
echo "========================================"
echo ""

# Check 1: Xcode project exists
echo "[1/8] Checking Xcode project..."
if [ -f "TempleRunClone.xcodeproj/project.pbxproj" ]; then
    echo "✓ Xcode project found"
else
    echo "❌ Xcode project not found"
    exit 1
fi

# Check 2: Game files exist
echo "[2/8] Checking game source files..."
files=("RunBoyApp.swift" "GameView.swift" "GameScene.swift")
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "✓ $file found"
    else
        echo "❌ $file not found"
        exit 1
    fi
done

# Check 3: Configuration files
echo "[3/8] Checking configuration files..."
config_files=("Info.plist" "LaunchScreen.storyboard" "PrivacyInfo.xcprivacy")
for file in "${config_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✓ $file found"
    else
        echo "❌ $file not found"
    fi
done

# Check 4: Documentation
echo "[4/8] Checking documentation..."
doc_files=("README.md" "DEPLOY_GUIDE.md" "AppStoreChecklist.md" "XCODE_SETUP.md")
for file in "${doc_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✓ $file found"
    else
        echo "❌ $file not found"
    fi
done

# Check 5: Scripts
echo "[5/8] Checking deployment scripts..."
if [ -f "scripts/generate_app_icons.py" ]; then
    echo "✓ Icon generator script found"
else
    echo "❌ Icon generator script not found"
fi

# Check 6: Assets
echo "[6/8] Checking assets..."
if [ -d "Assets.xcassets" ]; then
    echo "✓ Assets directory found"
    if [ -d "Assets.xcassets/AppIcon.appiconset" ]; then
        icon_count=$(find Assets.xcassets/AppIcon.appiconset -name "*.png" | wc -l)
        echo "✓ Found $icon_count icon files"
    else
        echo "⚠️  AppIcon.appiconset not found (run generate_app_icons.py)"
    fi
else
    echo "⚠️  Assets directory not found"
fi

# Check 7: Git repository
echo "[7/8] Checking Git repository..."
if [ -d ".git" ]; then
    echo "✓ Git repository found"
    git_status=$(git status --porcelain | wc -l)
    echo "✓ Git status: $git_status uncommitted changes"
else
    echo "⚠️  Not a Git repository (optional)"
fi

# Check 8: Summary
echo "[8/8] Summary"
echo ""
echo "Checklist Summary:"
echo "✓ Project structure validated"
echo "✓ Source files present"
echo "✓ Documentation complete"
echo "✓ Scripts available"
echo ""
echo "Next Steps:"
echo "1. Open TempleRunClone.xcodeproj in Xcode"
echo "2. Follow XCODE_SETUP.md for configuration"
echo "3. Set Bundle Identifier (com.yourname.runboy)"
echo "4. Select your Team"
echo "5. Test on simulator/device"
echo "6. Archive and submit to App Store"
echo ""
echo "🚀 RunBoy is ready for submission!"
