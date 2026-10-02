import SwiftUI

struct ContentView: View {
    @State private var gameScene: GameScene? = nil

    var body: some View {
        ZStack {
            if let scene = gameScene {
                SpriteView(scene: scene)
                    .ignoresSafeArea()
            } else {
                Color.black
                    .ignoresSafeArea()
                    .overlay(
                        VStack {
                            ProgressView()
                                .tint(.white)
                            Text("Loading RunBoy...")
                                .foregroundStyle(.white)
                                .font(.system(size: 18, weight: .semibold))
                        }
                    )
            }
        }
        .onAppear {
            if gameScene == nil {
                let scene = GameScene(size: CGSize(width: 390, height: 844))
                scene.scaleMode = .aspectFill
                self.gameScene = scene
            }
        }
    }
}

#Preview {
    ContentView()
}
