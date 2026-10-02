# RunBoy

RunBoy is an original endless-runner iOS game inspired by the feel of Temple Run-style gameplay.

Features:
- 3-lane movement
- Swipe controls for left/right and jump/slide
- Endless obstacle spawning
- Coin collection and score tracking
- High score persistence
- Pause, restart, and game-over flow
- Ready-to-extend SpriteKit architecture

Repository layout:
- `RunBoyApp.swift` — application entry point
- `GameView.swift` — SwiftUI wrapper for SpriteKit
- `GameScene.swift` — core runner gameplay logic
- `README.md` — project overview
- `AppStoreChecklist.md` — App Store deployment checklist
- `PrivacyInfo.xcprivacy` — privacy manifest placeholder
- `scripts/generate_app_icons.py` — generates placeholder App Icon assets for Xcode

How to run in Xcode:
1. Open Xcode.
2. Create a new iOS App project or add these files to an Xcode app target.
3. Ensure the app target is iOS 17+.
4. Add the generated App Icon asset set by running:
   `python3 scripts/generate_app_icons.py`
5. Build and run on a simulator or on a connected iPhone.

App Store readiness checklist:
- Add your own branding and final gameplay art
- Generate and export final App Icons at all required sizes
- Create a launch screen or use a polished splash screen
- Set the bundle identifier and signing credentials
- Add a privacy policy if analytics/ads are used
- Submit a build to TestFlight
- Complete App Store Connect metadata and screenshots
- Verify all required iOS app capabilities before release

Important note:
This project is an original game concept and does not use Temple Run branding, assets, or copyrighted visual content.

For the final App Store version, update the game title, artwork, icon set, and store metadata with your own design work.
