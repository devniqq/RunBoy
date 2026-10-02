# RunBoy

RunBoy is an original endless runner iOS game inspired by the feel of Temple Run-style gameplay. It is built in Swift using SpriteKit and designed to be easy to open in Xcode and iterate on.

Features:
- 3-lane movement
- Swipe controls for left/right and jump/slide
- Endless obstacle spawning
- Coin collection
- Score and high score persistence
- Game over and restart flow
- iPhone-friendly SpriteKit layout

Project structure:
- `RunBoyApp.swift` – app entry point
- `GameView.swift` – SwiftUI view hosting the SpriteKit scene
- `GameScene.swift` – game logic, lane movement, spawning, collisions, scoring

How to run in Xcode:
1. Open Xcode.
2. Create a new iOS App project.
3. Add these files to the project root.
4. Make sure the app target is set to iOS 17+.
5. Build and run on a simulator or a connected device.

Notes:
- This is an original game concept and does not use Temple Run branding, assets, or copyrighted content.
- For App Store deployment, add your own App Icons, Launch Screen, signing profile, and App Store Connect metadata.

Recommended production checklist before deploy:
- Add App Icon assets for all required sizes
- Create launch screen in Interface Builder or SwiftUI
- Set bundle identifier and signing team
- Add privacy policy URL if any analytics or ads are used
- Create App Store Connect listing
- Test on multiple iPhone sizes using TestFlight
- Add sound effects and music
- Tune difficulty and visuals for release balance

Suggested game naming:
- RunBoy
- RunBoy Rush
- RunBoy Dash

If you want, the next step can be a more polished version with:
- start menu
- pause screen
- power-ups
- sound effects
- polished graphics
- App Store-ready icon set and launch assets
