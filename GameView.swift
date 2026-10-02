import SwiftUI
import SpriteKit

struct GameView: View {
    @State private var scene: GameScene? = nil

    var body: some View {
        ZStack {
            if let scene {
                SpriteView(scene: scene)
                    .ignoresSafeArea()
            } else {
                Color.black
                    .ignoresSafeArea()
                    .overlay(
                        Text("Loading RunBoy...")
                            .foregroundStyle(.white)
                            .font(.system(size: 32, weight: .bold))
                    )
            }
        }
        .onAppear {
            if scene == nil {
                let newScene = GameScene(size: CGSize(width: 390, height: 844))
                newScene.scaleMode = .aspectFill
                self.scene = newScene
            }
        }
    }
}
