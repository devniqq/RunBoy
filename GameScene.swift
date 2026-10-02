import SpriteKit

final class GameScene: SKScene {
    private let lanePositions: [CGFloat] = [-120, 0, 120]
    private let obstacleColors: [UIColor] = [.systemRed, .systemOrange, .systemPurple]

    private let player: SKSpriteNode = {
        let node = SKSpriteNode(color: .systemBlue, size: CGSize(width: 42, height: 42))
        node.zPosition = 10
        return node
    }()

    private let ground: SKSpriteNode = {
        let node = SKSpriteNode(color: .darkGray, size: CGSize(width: 1000, height: 60))
        node.zPosition = 4
        return node
    }()

    private let scoreLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    private let highScoreLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    private let messageLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")

    private var currentLane = 1
    private var gameOver = false
    private var isJumping = false
    private var isSliding = false
    private var score = 0
    private var lastUpdateTime: TimeInterval = 0
    private var lastSpawnTime: TimeInterval = 0
    private var lastCoinTime: TimeInterval = 0
    private var scoreTimer: TimeInterval = 0
    private var touchStart: CGPoint?

    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = .black
        setupScene()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupScene() {
        score = 0
        currentLane = 1
        gameOver = false
        isJumping = false
        isSliding = false

        removeAllChildren()

        ground.position = CGPoint(x: 0, y: -330)
        addChild(ground)

        player.position = CGPoint(x: lanePositions[currentLane], y: -155)
        player.name = "player"
        addChild(player)

        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 28
        scoreLabel.position = CGPoint(x: 0, y: 260)
        scoreLabel.fontColor = .white
        addChild(scoreLabel)

        let best = UserDefaults.standard.integer(forKey: "RunBoyHighScore")
        highScoreLabel.text = "Best: \(best)"
        highScoreLabel.fontSize = 22
        highScoreLabel.position = CGPoint(x: 0, y: 220)
        highScoreLabel.fontColor = .systemYellow
        addChild(highScoreLabel)

        messageLabel.text = ""
        messageLabel.fontSize = 40
        messageLabel.position = CGPoint(x: 0, y: 50)
        messageLabel.fontColor = .white
        addChild(messageLabel)

        lastUpdateTime = 0
        lastSpawnTime = 0
        lastCoinTime = 0
        scoreTimer = 0
    }

    override func didMove(to view: SKView) {
        setupScene()
    }

    override func update(_ currentTime: TimeInterval) {
        if gameOver {
            return
        }

        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
        }

        let delta = currentTime - lastUpdateTime
        lastUpdateTime = currentTime

        scoreTimer += delta
        if scoreTimer >= 0.12 {
            score += 1
            scoreLabel.text = "Score: \(score)"
            scoreTimer = 0
        }

        if currentTime - lastSpawnTime >= 1.1 {
            spawnObstacle()
            lastSpawnTime = currentTime
        }

        if currentTime - lastCoinTime >= 0.8 {
            spawnCoin()
            lastCoinTime = currentTime
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        touchStart = touch.location(in: self)

        if gameOver {
            restartGame()
            return
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        guard let start = touchStart else { return }

        let end = touch.location(in: self)
        let dx = end.x - start.x
        let dy = end.y - start.y

        if abs(dx) > abs(dy) {
            if dx > 0 {
                moveLane(direction: 1)
            } else {
                moveLane(direction: -1)
            }
        } else {
            if dy > 0 {
                jump()
            } else {
                slide()
            }
        }

        touchStart = nil
    }

    private func moveLane(direction: Int) {
        currentLane = max(0, min(2, currentLane + direction))
        let targetX = lanePositions[currentLane]
        let moveAction = SKAction.moveTo(x: targetX, duration: 0.08)
        player.run(moveAction)
    }

    private func jump() {
        guard !gameOver, !isJumping, !isSliding else { return }
        isJumping = true

        let jumpUp = SKAction.moveBy(x: 0, y: 90, duration: 0.18)
        let jumpDown = SKAction.moveBy(x: 0, y: -90, duration: 0.18)

        player.run(SKAction.sequence([jumpUp, jumpDown])) { [weak self] in
            self?.isJumping = false
        }
    }

    private func slide() {
        guard !gameOver, !isJumping, !isSliding else { return }
        isSliding = true

        let shrink = SKAction.scaleY(to: 0.55, duration: 0.12)
        let expand = SKAction.scaleY(to: 1.0, duration: 0.12)

        player.run(SKAction.sequence([shrink, expand])) { [weak self] in
            self?.isSliding = false
        }
    }

    private func spawnObstacle() {
        let obstacle = SKSpriteNode(
            color: obstacleColors[Int.random(in: 0..<obstacleColors.count)],
            size: CGSize(width: 52, height: 52)
        )

        let laneIndex = Int.random(in: 0..<3)
        obstacle.position = CGPoint(x: lanePositions[laneIndex], y: 420)
        obstacle.zPosition = 3
        addChild(obstacle)

        let moveAction = SKAction.moveTo(y: -330, duration: 2.4)
        obstacle.run(moveAction) { [weak self] in
            obstacle.removeFromParent()
        }

        let collisionCheck = SKAction.sequence([
            SKAction.wait(forDuration: 0.05),
            SKAction.run { [weak self] in
                guard let self, !self.gameOver else { return }
                if obstacle.intersects(self.player) {
                    self.endGame()
                }
            }
        ])

        obstacle.run(collisionCheck)
    }

    private func spawnCoin() {
        let coin = SKSpriteNode(color: .systemYellow, size: CGSize(width: 20, height: 20))
        let laneIndex = Int.random(in: 0..<3)
        coin.position = CGPoint(x: lanePositions[laneIndex], y: 420)
        coin.zPosition = 5
        addChild(coin)

        let moveAction = SKAction.moveTo(y: -330, duration: 2.4)
        coin.run(moveAction) { [weak self] in
            coin.removeFromParent()
        }

        let coinCheck = SKAction.sequence([
            SKAction.wait(forDuration: 0.05),
            SKAction.run { [weak self] in
                guard let self, !self.gameOver else { return }
                if coin.intersects(self.player) {
                    self.score += 10
                    self.scoreLabel.text = "Score: \(self.score)"
                    coin.removeFromParent()
                }
            }
        ])

        coin.run(coinCheck)
    }

    private func endGame() {
        guard !gameOver else { return }
        gameOver = true

        let best = UserDefaults.standard.integer(forKey: "RunBoyHighScore")
        if score > best {
            UserDefaults.standard.set(score, forKey: "RunBoyHighScore")
        }

        let finalBest = UserDefaults.standard.integer(forKey: "RunBoyHighScore")
        highScoreLabel.text = "Best: \(finalBest)"

        messageLabel.text = "Game Over"
        messageLabel.fontSize = 40
        messageLabel.position = CGPoint(x: 0, y: 60)
        addChild(messageLabel)

        let restartLabel = SKLabelNode(fontNamed: "AvenirNext")
        restartLabel.text = "Tap to Restart"
        restartLabel.fontSize = 22
        restartLabel.fontColor = .white
        restartLabel.position = CGPoint(x: 0, y: 0)
        addChild(restartLabel)
    }

    private func restartGame() {
        setupScene()
    }
}
