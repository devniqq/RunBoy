# RunBoy App Store Setup & Deployment Guide

## Quick Start in Xcode

1. **Clone or open the project in Xcode**
   ```bash
   git clone https://github.com/devniqq/TempleRunClone.git
   cd TempleRunClone
   open TempleRunClone.xcodeproj
   ```

2. **Generate App Icons**
   ```bash
   python3 scripts/generate_app_icons.py
   ```
   This creates placeholder icons in `Assets.xcassets/AppIcon.appiconset/`.

3. **Configure the project in Xcode**
   - Select the app target
   - Go to **General**
   - Set **Bundle Identifier** (e.g., `com.yourname.runboy`)
   - Set **Team** (your Apple Developer account)
   - Ensure **iOS Deployment Target** is 17.0 or higher

4. **Build and run**
   ```
   Cmd + R (or use the Play button)
   ```

## For App Store Submission

### Step 1: Finalize Branding
- Replace placeholder icons with your own 1024×1024 icon artwork
- Customize the launch screen in `LaunchScreen.storyboard` if desired
- Update the app name in `Info.plist` if you want a different display name

### Step 2: Configure App Store Connect
1. Go to [App Store Connect](https://appstoreconnect.apple.com/)
2. Create a new app:
   - **App Name**: RunBoy
   - **Bundle ID**: com.yourname.runboy (must match Xcode)
   - **SKU**: Any unique identifier (e.g., runboy-001)
   - **Platform**: iOS
3. Fill in app metadata:
   - Description
   - Keywords
   - Support URL
   - Privacy Policy URL
   - Age rating

### Step 3: Create Test Build
1. In Xcode, select **Product > Archive**
2. Once the archive is complete, click **Distribute App**
3. Choose **TestFlight & App Store**
4. Select **App Store Connect**
5. Follow the prompts to sign and upload

### Step 4: TestFlight Internal Testing
1. In App Store Connect, go to your app
2. Navigate to **TestFlight**
3. Add yourself as a beta tester
4. Install and test the build on your iPhone
5. Verify:
   - Game starts correctly
   - All controls (swipe, jump, slide) work
   - Score and high score persist
   - Pause and restart work
   - No crashes on extended play

### Step 5: Submit for Review
1. Once TestFlight testing passes, return to **App Store**
2. Click **Prepare for Submission**
3. Add:
   - Screenshots (5–12 per device type)
   - App preview video (optional but recommended)
   - Release notes
   - Version number (e.g., 1.0)
4. Under **Build**, select the tested build
5. Click **Submit for Review**
6. Apple will review (typically 24–48 hours)

### Step 6: Release
Once approved, you can:
- **Release immediately** (available on App Store right away)
- **Schedule release** (pick a date to go live)
- **Manual release** (release when you choose)

## Important Checklist Before Submission

- [ ] Bundle ID is unique and matches Xcode
- [ ] Team/signing profile is set
- [ ] App name is finalized
- [ ] App icon is custom (not placeholder)
- [ ] Privacy policy URL is valid and public
- [ ] Age rating is appropriate (RunBoy is 4+)
- [ ] No crashes or bugs on TestFlight
- [ ] High score persistence works
- [ ] Game difficulty is balanced
- [ ] Screenshots show key gameplay
- [ ] Release notes are written
- [ ] Build version number matches submission version

## Optional Enhancements Before Release

- Add sound effects and background music
- Implement ads (if monetization desired)
- Add achievements or leaderboards
- Create a tutorial on first launch
- Add settings/options menu
- Implement haptic feedback for collisions
- Add more obstacle types and power-ups

## Support & Documentation

- [Apple App Store Connect Help](https://help.apple.com/app-store-connect/)
- [TestFlight Beta Testing Guide](https://developer.apple.com/testflight/)
- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [Xcode Archive & Submit Guide](https://developer.apple.com/documentation/xcode/distributing-your-app-for-beta-testing-through-testflight)

## After Launch

Monitor your app:
- Check crash logs in App Store Connect
- Review user ratings and feedback
- Plan future updates
- Add new features based on user requests

Good luck with RunBoy! 🚀
