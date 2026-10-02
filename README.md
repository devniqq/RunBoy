# RunBoy

RunBoy is an original, endless-runner iOS game built entirely in Swift with SpriteKit. It's inspired by the fast-paced, addictive gameplay of classic endless runners.

## Features

- **3-Lane Running**: Swipe left/right to change lanes and navigate obstacles
- **Jump & Slide**: Swipe up to jump over obstacles, swipe down to slide under them
- **Dynamic Difficulty**: The game gets progressively harder as your score increases
- **Coin Collectibles**: Grab coins for bonus points
- **High Score Tracking**: Your best score is saved locally
- **Smooth Controls**: Responsive swipe-based controls
- **Pause & Resume**: Pause anytime during gameplay
- **Clean UI**: Simple, modern interface with score and high score displays

## Project Structure

```
TempleRunClone/
├── RunBoyApp.swift          # App entry point
├── ContentView.swift        # Main game view
├── GameScene.swift          # Core game logic and SpriteKit scene
├── LaunchScreen.storyboard  # Launch screen design
├── Info.plist               # App configuration
├── PrivacyInfo.xcprivacy    # Privacy manifest
├── DEPLOY_GUIDE.md          # App Store deployment guide
├── AppStoreChecklist.md     # Pre-submission checklist
├── README.md                # This file
├── scripts/
│   ├── deploy.sh            # Automated deployment script
│   └── generate_app_icons.py # App icon generator
└── Assets.xcassets/
    └── AppIcon.appiconset/  # App icons (auto-generated)
```

## Quick Start

### Prerequisites
- Xcode 15.0+
- iOS 17.0+ deployment target
- Apple Developer account (for App Store submission)

### Local Development

1. Clone the repository:
   ```bash
   git clone https://github.com/devniqq/TempleRunClone.git
   cd TempleRunClone
   ```

2. Open in Xcode:
   ```bash
   open TempleRunClone.xcodeproj
   ```

3. Generate placeholder app icons:
   ```bash
   python3 scripts/generate_app_icons.py
   ```

4. Configure your bundle identifier and team:
   - Select the project in Xcode
   - Go to **Signing & Capabilities**
   - Set your **Team**
   - Update **Bundle Identifier** (e.g., `com.yourname.runboy`)

5. Build and run:
   - Press `Cmd + R` or click the Play button
   - Test on simulator or connected iPhone

## How to Play

1. **Start**: Tap anywhere to begin
2. **Move**: Swipe left or right to change lanes
3. **Jump**: Swipe up to jump over obstacles
4. **Slide**: Swipe down to slide under obstacles
5. **Collect**: Grab yellow coins for bonus points
6. **Survive**: Avoid red, orange, and purple obstacles
7. **Pause**: Tap the pause button (❚❚) in the top-left
8. **Restart**: When you collide, tap to restart

## Game Mechanics

- **Score**: +1 point per frame (~60 FPS)
- **Coins**: +10 points when collected
- **Difficulty**: Obstacles spawn faster as your score increases
- **Speed**: The world moves faster as difficulty increases
- **High Score**: Your best score is saved automatically

## App Store Deployment

For complete deployment instructions, see **DEPLOY_GUIDE.md**.

Quick checklist:
1. ✅ Generate final app icons
2. ✅ Test thoroughly on iOS 17+
3. ✅ Set up Apple Developer account
4. ✅ Create app in App Store Connect
5. ✅ Archive and submit via TestFlight
6. ✅ Complete App Store metadata
7. ✅ Submit for review

## Development & Customization

### Modify Game Difficulty
In `GameScene.swift`, adjust these values:
- `baseRunSpeed`: Starting game speed
- `gravity`: Jump physics
- `jumpForce`: Jump height
- Obstacle and coin spawn rates

### Change Colors
Modify `obstacleColors` in `GameScene.swift` to customize obstacle appearance.

### Add Sound
Use `AVFoundation` to add music and sound effects in `GameScene.swift`.

### Customize Appearance
Edit `LaunchScreen.storyboard` for the launch screen appearance.

## Technical Details

- **Framework**: SpriteKit
- **UI**: SwiftUI
- **Language**: Swift 5.9+
- **Minimum iOS**: 17.0
- **Architecture**: Single-scene runner with frame-based updates
- **Physics**: Custom gravity and collision detection
- **Persistence**: UserDefaults for high score storage

## Performance

- Optimized for 60 FPS gameplay
- Efficient obstacle and coin spawning
- Minimal memory footprint
- Smooth animations and transitions

## License

MIT License - see LICENSE file for details.

## Credits

Developed by Devniqq | Original concept inspired by endless-runner games.

## Support

For issues, suggestions, or contributions, visit the GitHub repository:
https://github.com/devniqq/TempleRunClone

---

**Ready to play RunBoy? Download it from the App Store!** 🎮
