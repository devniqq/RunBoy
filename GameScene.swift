import SpriteKit

enum GamePhase {
    case menu
    case playing
    case paused
    case gameOver
}

final class GameScene: SKScene {
    private let lanePositions: [CGFloat] = [-120, 0, 120]
    private let obstacleColors: [UIColor] = [.systemRed, .systemOrange, .systemPurple]

    private let player: SKSpriteNode = {
        let node = SKSpriteNode(color: .systemBlue, size: CGSize(width: 42, height: 42))
        node.zPosition = 20
        node.name = "player"
        return node
    }()

    private let ground: SKSpriteNode = {
        let node = SKSpriteNode(color: .darkGray, size: CGSize(width: 1000, height: 70))
        node.zPosition = 4
        return node
    }()

    private let scoreLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    private let highScoreLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    private let statusLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    private let promptLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    private let pauseButton = SKLabelNode(fontNamed: "AvenirNext-Bold")

    private var currentLane = 1
    private var phase: GamePhase = .menu
    private var score = 0
    private var lastUpdateTime: TimeInterval = 0
    private var spawnTimer: TimeInterval = 0
    private var coinTimer: TimeInterval = 0
    private var cameraSpeed: CGFloat = 220
    private var touchStart: CGPoint?
    private var isJumping = false
    private var isSliding = false
    private var slideTimeRemaining: TimeInterval = 0
    private var playerBaseY: CGFloat = -165
    private var verticalVelocity: CGFloat = 0
    private let gravity: CGFloat = -1500
    private let jumpForce: CGFloat = 620

    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = .black
        setupScene()
        showMenu()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupScene() {
        removeAllChildren()

        let background = SKShapeNode(rectOf: CGSize(width: size.width, height: size.height))
        background.fillColor = .black
        background.strokeColor = .clear
        background.zPosition = -10
        addChild(background)

        let laneLine1 = SKShapeNode(rectOf: CGSize(width: 2, height: size.height))
        laneLine1.fillColor = .white
        laneLine1.strokeColor = .clear
        laneLine1.position = CGPoint(x: -120, y: 0)
        laneLine1.alpha = 0.15
        laneLine1.zPosition = -5
        addChild(laneLine1)

        let laneLine2 = SKShapeNode(rectOf: CGSize(width: 2, height: size.height))
        laneLine2.fillColor = .white
        laneLine2.strokeColor = .clear
        laneLine2.position = CGPoint(x: 120, y: 0)
        laneLine2.alpha = 0.15
        laneLine2.zPosition = -5
        addChild(laneLine2)

        ground.position = CGPoint(x: 0, y: -335)
        addChild(ground)

        player.position = CGPoint(x: lanePositions[currentLane], y: playerBaseY)
        player.size = CGSize(width: 42, height: 42)
        addChild(player)

        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 28
        scoreLabel.position = CGPoint(x: 0, y: 260)
        scoreLabel.fontColor = .white
        addChild(scoreLabel)

        let bestScore = UserDefaults.standard.integer(forKey: "RunBoyHighScore")
        highScoreLabel.text = "Best: \(bestScore)"
        highScoreLabel.fontSize = 22
        highScoreLabel.position = CGPoint(x: 0, y: 225)
        highScoreLabel.fontColor = .systemYellow
        addChild(highScoreLabel)

        statusLabel.text = ""
        statusLabel.fontSize = 42
        statusLabel.position = CGPoint(x: 0, y: 100)
        statusLabel.fontColor = .white
        addChild(statusLabel)

        promptLabel.text = ""
        promptLabel.fontSize = 18
        promptLabel.position = CGPoint(x: 0, y: 45)
        promptLabel.fontColor = .white
        addChild(promptLabel)

        pauseButton.text = "❚❚"
        pauseButton.fontSize = 24
        pauseButton.position = CGPoint(x: -150, y: 265)
        pauseButton.fontColor = .white
        addChild(pauseButton)

        currentLane = 1
        score = 0
        lastUpdateTime = 0
        spawnTimer = 0
        coinTimer = 0
        slideTimeRemaining = 0
        isJumping = false
        isSliding = false
        verticalVelocity = 0
    }

    private func showMenu() {
        phase = .menu
        statusLabel.text = "RunBoy"
        statusLabel.fontSize = 52
        statusLabel.position = CGPoint(x: 0, y: 110)
        promptLabel.text = "Tap to Start"
        promptLabel.fontSize = 22
        promptLabel.position = CGPoint(x: 0, y: 30)

        let bestScore = UserDefaults.standard.integer(forKey: "RunBoyHighScore")
        highScoreLabel.text = "Best: \(bestScore)"
    }

    private func startGame() {
        setupScene()
        phase = .playing
        statusLabel.text = ""
        promptLabel.text = ""
    }

    private func togglePause() {
        if phase == .playing {
            phase = .paused
            statusLabel.text = "Paused"
            statusLabel.fontSize = 42
            statusLabel.position = CGPoint(x: 0, y: 100)
            promptLabel.text = "Tap again to Resume"
            promptLabel.fontSize = 18
            promptLabel.position = CGPoint(x: 0, y: 45)
        } else if phase == .paused {
            phase = .playing
            statusLabel.text = ""
            promptLabel.text = ""
        }
    }

    private func endGame() {
        guard phase == .playing else { return }
        phase = .gameOver

        let currentBest = UserDefaults.standard.integer(forKey: "RunBoyHighScore")
        if score > currentBest {
            UserDefaults.standard.set(score, forKey: "RunBoyHighScore")
        }

        highScoreLabel.text = "Best: \(UserDefaults.standard.integer(forKey: "RunBoyHighScore"))"
        statusLabel.text = "Game Over"
        statusLabel.fontSize = 42
        statusLabel.position = CGPoint(x: 0, y: 100)
        promptLabel.text = "Tap to Restart"
        promptLabel.fontSize = 18
        promptLabel.position = CGPoint(x: 0, y: 45)
    }

    override func update(_ currentTime: TimeInterval) {
        guard phase == .playing else { return }

        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
        }

        let delta = currentTime - lastUpdateTime
        lastUpdateTime = currentTime

        updatePlayerPhysics(delta: delta)
        updateSpawns(delta: delta)
        updateWorld(delta: delta)
        updateScore(delta: delta)
    }

    private func updatePlayerPhysics(delta: TimeInterval) {
        if isJumping {
            verticalVelocity += gravity * CGFloat(delta)
            player.position.y += verticalVelocity * CGFloat(delta)

            if player.position.y <= playerBaseY {
                player.position.y = playerBaseY
                verticalVelocity = 0
                isJumping = false
            }
        }

        if isSliding {
            slideTimeRemaining -= delta
            if slideTimeRemaining <= 0 {
                player.size.height = 42
                isSliding = false
            }
        }
    }

    private func updateSpawns(delta: TimeInterval) {
        spawnTimer += delta
        coinTimer += delta

        let obstacleInterval = max(0.7, 1.2 - Double(score) * 0.008)
        if spawnTimer >= obstacleInterval {
            spawnObstacle()
            spawnTimer = 0
        }

        let coinInterval = max(0.45, 0.85 - Double(score) * 0.004)
        if coinTimer >= coinInterval {
            spawnCoin()
            coinTimer = 0
        }
    }

    private func updateWorld(delta: TimeInterval) {
        cameraSpeed = 220 + CGFloat(min(score, 800)) * 0.8

        for child in children {
            if child.name == "obstacle" || child.name == "coin" {
                child.position.y -= cameraSpeed * CGFloat(delta)

                if child.position.y < -500 {
                    child.removeFromParent()
                    continue
                }

                if child.name == "obstacle" && child.intersects(player) {
                    endGame()
                }

                if child.name == "coin" && child.intersects(player) {
                    score += 10
                    scoreLabel.text = "Score: \(score)"
                    child.removeFromParent()
                }
            }
        }
    }

    private func updateScore(delta: TimeInterval) {
        _ = delta
        score += 1
        scoreLabel.text = "Score: \(score)"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        if phase == .menu {
            startGame()
            return
        }

        if phase == .gameOver {
            startGame()
            return
        }

        if location.x < frame.minX + 80 && location.y > frame.maxY - 160 {
            togglePause()
            return
        }

        touchStart = location
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard phase == .playing else { return }
        guard let touch = touches.first else { return }
        guard let start = touchStart else { return }

        let end = touch.location(in: self)
        let dx = end.x - start.x
        let dy = end.y - start.y

        if abs(dx) > abs(dy) {
            let threshold: CGFloat = 25
            if dx > threshold {
                moveLane(direction: 1)
            } else if dx < -threshold {
                moveLane(direction: -1)
            }
        } else {
            let threshold: CGFloat = 25
            if dy > threshold {
                jump()
            } else if dy < -threshold {
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
        guard !isJumping && !isSliding else { return }
        isJumping = true
        verticalVelocity = jumpForce
    }

    private func slide() {
        guard !isJumping && !isSliding else { return }
        isSliding = true
        slideTimeRemaining = 0.6
        player.size.height = 24
    }

    private func spawnObstacle() {
        let obstacle = SKSpriteNode(
            color: obstacleColors[Int.random(in: 0..<obstacleColors.count)],
            size: CGSize(width: 52, height: 52)
        )

        let laneIndex = Int.random(in: 0..<3)
        obstacle.position = CGPoint(x: lanePositions[laneIndex], y: 440)
        obstacle.zPosition = 3
        obstacle.name = "obstacle"
        addChild(obstacle)
    }

    private func spawnCoin() {
        let coin = SKSpriteNode(color: .systemYellow, size: CGSize(width: 20, height: 20))
        let laneIndex = Int.random(in: 0..<3)
        coin.position = CGPoint(x: lanePositions[laneIndex], y: 420)
        coin.zPosition = 5
        coin.name = "coin"
        addChild(coin)
    }
}
