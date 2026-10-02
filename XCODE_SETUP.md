# RunBoy Xcode Setup Guide

## Step 1: Open Project in Xcode

```bash
cd TempleRunClone
open TempleRunClone.xcodeproj
```

## Step 2: Configure Project Settings

### 2.1 Bundle Identifier
1. Select the project in the navigator
2. Select the RunBoy target
3. Go to **General** tab
4. Set **Bundle Identifier** to:
   ```
   com.yourname.runboy
   ```
   Replace `yourname` with your name or company (e.g., `com.devniqq.runboy`)

### 2.2 Team Selection
1. Still in **General** tab
2. Under **Signing & Capabilities**
3. Select your **Team** from dropdown
4. If no team appears:
   - Go to **Xcode > Preferences > Accounts**
   - Add your Apple Developer account
   - Refresh and retry

### 2.3 Minimum iOS Version
1. In **General** tab
2. Set **Minimum Deployments** to **iOS 17.0**

### 2.4 App Display Name
1. Select **Info** tab
2. Set **Display Name** (Bundle name) to:
   ```
   RunBoy
   ```

## Step 3: App Icons

### 3.1 Generate Placeholder Icons
```bash
python3 scripts/generate_app_icons.py
```

This creates icons in `Assets.xcassets/AppIcon.appiconset/`

### 3.2 Replace with Custom Icons (Optional)
1. Open `Assets.xcassets` in Xcode
2. Select `AppIcon`
3. Drag and drop your custom icon files
4. Ensure all sizes are filled

## Step 4: Launch Screen

1. Open `LaunchScreen.storyboard`
2. Verify design looks correct
3. Text reads "RUNBOY" and "Endless Runner"
4. Dark background is applied

## Step 5: Build & Test Locally

### 5.1 Select Simulator or Device
- Click the device selector in Xcode toolbar
- Choose iPhone 15 Pro Max or your device

### 5.2 Build and Run
```
Cmd + R
```
or click the Play button.

### 5.3 Test Gameplay
- [ ] App launches without crashes
- [ ] Start screen appears
- [ ] Tap to start game
- [ ] Game plays smoothly
- [ ] Swipe controls work (left/right/up/down)
- [ ] Score increases
- [ ] Pause button works
- [ ] Pause and resume work
- [ ] Game Over screen appears after collision
- [ ] Restart works
- [ ] High score persists after app close

## Step 6: Archive for Distribution

### 6.1 Build Archive
1. Select **Product > Archive**
2. Wait for build to complete
3. Xcode Organizer opens automatically

### 6.2 Distribute App
1. In Organizer, select the RunBoy archive
2. Click **Distribute App**
3. Select **TestFlight & App Store**
4. Select **App Store Connect**
5. Follow prompts:
   - Sign in with Apple ID
   - Select team
   - Confirm app
   - Submit to App Store Connect

## Step 7: App Store Connect Setup

### 7.1 Create App
1. Go to [App Store Connect](https://appstoreconnect.apple.com/)
2. Click **My Apps**
3. Click **+** to create new app
4. Fill in:
   - **Platform**: iOS
   - **Name**: RunBoy
   - **Primary Language**: English
   - **Bundle ID**: com.yourname.runboy (must match Xcode)
   - **SKU**: runboy-001
   - **User Access**: Full Access

### 7.2 Complete App Information

#### Pricing and Availability
- **Price Tier**: Free
- **Availability**: Worldwide

#### App Information
- **Primary Category**: Games
- **Subcategory**: Action
- **Content Rights**: Owned
- **Age Rating**: 4+

### 7.3 Metadata

#### Description
```
RunBoy is an endless runner game that challenges you to navigate through three lanes, avoiding obstacles and collecting coins. 

Swipe to move left and right, jump over barriers, and slide under obstacles. How high can you score?

Features:
- Fast-paced endless runner gameplay
- 3-lane navigation system
- Jump and slide mechanics
- Coin collection bonuses
- Progressive difficulty
- High score tracking
- Simple, intuitive controls
```

#### Keywords
```
endless runner, action game, casual game, arcade, reflex
```

#### Support URL
```
https://github.com/devniqq/TempleRunClone
```

#### Privacy Policy URL
```
[Add your privacy policy URL here]
```

If you don't have one, create a simple privacy policy stating:
"RunBoy does not collect personal data. The game uses UserDefaults only to store high scores locally on your device."

### 7.4 Ratings
1. Complete the **Age Rating Questionnaire**
2. For RunBoy, typical answers:
   - No violence
   - No mature content
   - No ads/in-app purchases
   - Age: 4+

### 7.5 Screenshots

Create 5-6 screenshots for each device family:

**iPhone 6.5" (required):**
1. Start screen
2. Gameplay - running and collecting coins
3. Gameplay - jumping over obstacle
4. Gameplay - sliding under obstacle
5. Game over screen with high score
6. High score display

**iPad (optional):**
- Same content, landscape orientation

### 7.6 Preview Video (Optional)
- 30-45 seconds
- Show gameplay
- Show start/pause/game over

## Step 8: TestFlight Beta Testing

### 8.1 Internal Testing
1. In App Store Connect, go to **TestFlight**
2. Click **Internal Testing**
3. Add yourself as tester
4. Install build on your iPhone via TestFlight app
5. Test thoroughly:
   - All game mechanics
   - Multiple play sessions
   - Long gameplay (10+ minutes)
   - Pause/resume stability
   - No crashes

### 8.2 External Testing (Optional)
1. Add beta testers via email
2. Send TestFlight invite link
3. Collect feedback
4. Fix any critical bugs

## Step 9: Submit for Review

### 9.1 Prepare Submission
1. In App Store Connect, go to **App Store**
2. Click **Prepare for Submission**
3. Ensure all required fields are complete

### 9.2 Add Release Notes
```
Version 1.0 - Launch

Welcome to RunBoy! This is the first release of our endless runner game.

Enjoy fast-paced gameplay with challenging obstacles and coin collection.
```

### 9.3 Select Build
1. Under **Build**, click **Select a build**
2. Choose your latest TestFlight build
3. Click **Add**

### 9.4 Submit for Review
1. Review all information
2. Check **Compliance**:
   - [ ] Yes, this app qualifies for Export Compliance
   - [ ] No encryption
3. Click **Submit for Review**
4. Confirm submission

## Step 10: Monitor Review

1. Apple typically reviews within 24-48 hours
2. Check **App Store Connect > Activity**
3. Wait for approval or feedback
4. If rejected, address issues and resubmit
5. Once approved, release immediately or schedule

## Step 11: Release to App Store

### Option 1: Immediate Release
1. Click **Release This Version**
2. Confirm
3. App goes live immediately

### Option 2: Scheduled Release
1. Click **Schedule Release**
2. Choose release date/time
3. App goes live automatically

## Step 12: Post-Launch

1. Monitor **Analytics**
2. Check **Ratings & Reviews**
3. Fix any reported bugs in version 1.1
4. Plan new features
5. Update regularly

---

## Troubleshooting

### Issue: "No Team Selected"
**Solution:**
1. Go to **Xcode > Preferences > Accounts**
2. Add your Apple Developer account
3. Click **Manage Certificates**
4. Ensure iOS Development certificate exists
5. Return to project, select team

### Issue: "Bundle ID already in use"
**Solution:**
Change Bundle ID to something unique, e.g.:
- com.yourname.runboy
- com.yourlastname.runboy
- com.companyname.runboy

### Issue: "Archive failed to export"
**Solution:**
1. Clean build folder: **Cmd + Shift + K**
2. Rebuild: **Cmd + B**
3. Archive again: **Cmd + Option + R**

### Issue: "Signing certificate not found"
**Solution:**
1. Go to **Signing & Capabilities**
2. Toggle **Automatically manage signing** off
3. Toggle on again
4. Xcode will regenerate certificates

---

## Quick Command Line Build

If you prefer terminal:

```bash
# Build for simulator
xcodebuild -scheme RunBoyApp -configuration Debug -sdk iphonesimulator build

# Archive for App Store
xcodebuild -scheme RunBoyApp -configuration Release archive -archivePath ./build/RunBoy.xcarchive

# Export IPA
xcodebuild -exportArchive -archivePath ./build/RunBoy.xcarchive -exportOptionsPlist ./export_options.plist -exportPath ./build
```

---

## Final Checklist Before Submit

- [ ] Bundle ID set and unique
- [ ] Team selected
- [ ] iOS deployment target is 17.0
- [ ] App icons generated and verified
- [ ] Launch screen looks correct
- [ ] All gameplay tested
- [ ] High score persistence works
- [ ] No crashes or warnings
- [ ] Archive builds successfully
- [ ] App Store Connect account active
- [ ] App created in App Store Connect
- [ ] Metadata complete (name, description, keywords)
- [ ] Screenshots uploaded
- [ ] Age rating set
- [ ] Privacy policy URL added
- [ ] Build uploaded via TestFlight
- [ ] Internal testing passed
- [ ] Ready to submit

---

**Good luck with RunBoy! 🚀**
