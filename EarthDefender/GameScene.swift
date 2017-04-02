import SpriteKit

//func + (left: CGPoint, right: CGPoint) -> CGPoint {
//    return CGPoint(x: left.x + right.x, y: left.y + right.y)
//}
//
//func - (left: CGPoint, right: CGPoint) -> CGPoint {
//    return CGPoint(x: left.x - right.x, y: left.y - right.y)
//}
//
//func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
//    return CGPoint(x: point.x * scalar, y: point.y * scalar)
//}
//
//func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
//    return CGPoint(x: point.x / scalar, y: point.y / scalar)
//}
//
//#if !(arch(x86_64) || arch(arm64))
//    func sqrt(a: CGFloat) -> CGFloat {
//        return CGFloat(sqrtf(Float(a)))
//    }
//#endif
//
//extension CGPoint {
//    func length() -> CGFloat {
//        return sqrt(x*x + y*y)
//    }
//    
//    func normalized() -> CGPoint {
//        return self / length()
//    }
//}
//

class GameScene: SKScene, SKPhysicsContactDelegate {
    var newPlayer: Player = Player.sharedInstance
        struct PhysicsCategory {
        static let None      : UInt32 = 0
        static let All       : UInt32 = UInt32.max
        static let Monster   : UInt32 = 0b1       // 1
        static let Projectile: UInt32 = 0b10      // 2
    }
    
    // 1
    let player = SKSpriteNode(imageNamed: "earthDefenderSataliteSprite")
    let background = SKSpriteNode(imageNamed: "earthDefenderbackground")
    let livesLabel: SKLabelNode = SKLabelNode()
    let monstersLeftLabel: SKLabelNode = SKLabelNode()

    
    override func didMove(to view: SKView) {
        
        newPlayer.monstersLeftForLevel = 25
        
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        // 2
        backgroundColor = SKColor.white
        // 3
        player.xScale = 0.4
        player.yScale = 0.4
        
        background.xScale = 0.9
        background.yScale = 1.3
        
        background.position = CGPoint(x: size.width * 0.3, y: size.height * 0.5)
        background.zPosition = 1
        
        player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.18)
        player.zPosition = background.zPosition + 1
        // 4
        
        livesLabel.position = CGPoint(x: 70, y: 630)
        livesLabel.zPosition = 100
        livesLabel.text = "lives: \(newPlayer.lives)"
        livesLabel.fontColor = UIColor.red
        livesLabel.fontSize = 25
        
        monstersLeftLabel.position = CGPoint(x: 270, y: 630)
        monstersLeftLabel.zPosition = 100
        monstersLeftLabel.text = "asteroids left: \(newPlayer.monstersLeftForLevel)"
        monstersLeftLabel.fontColor = UIColor.green
        monstersLeftLabel.fontSize = 25
        
        addChild(background)
        addChild(player)
        addChild(livesLabel)
        addChild(monstersLeftLabel)
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addMonster),
                SKAction.wait(forDuration: 1.0)
                ])
        ))
        let backgroundMusic = SKAudioNode(fileNamed: "background-music-aac.caf")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
    }
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addMonster() {
        
        // Create sprite
        let monster = SKSpriteNode(imageNamed: "EarthDefenderasteroid")
        monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size) // 1
        monster.physicsBody?.isDynamic = true // 2
        monster.physicsBody?.categoryBitMask = PhysicsCategory.Monster // 3
        monster.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile // 4
        monster.physicsBody?.collisionBitMask = PhysicsCategory.None // 5
        
        // Determine where to spawn the monster along the Y axis
        let actualY = size.height //random(min: monster.size.height/2, max: size.height - monster.size.height/2)
        let actualX = random(min: 1, max: 350)
        monster.zPosition = background.zPosition + 1
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        monster.position = CGPoint(x: actualX, y: actualY)
        
        monster.xScale = 0.3
        monster.yScale = 0.3
        
        // Add the monster to the scene
        addChild(monster)
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: actualY - actualY), duration: TimeInterval(actualDuration))
        
        let actionMoveDone = SKAction.removeFromParent()
        
        let loseAction = SKAction.run() {
            self.newPlayer.decrementLives()
            self.livesLabel.text = "lives: \(self.newPlayer.lives)"
            
            
            
            if self.newPlayer.lives <= 0 {
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = GameOverScene(size: self.size)
                self.view?.presentScene(gameScene, transition: reveal)
            }
        }
        monster.run(SKAction.sequence([actionMove, loseAction, actionMoveDone]))
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        run(SKAction.playSoundFileNamed("pew-pew-lei.caf", waitForCompletion: false))
        
        // 1 - Choose one of the touches to work with
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        // 2 - Set up initial location of projectile
        let projectile = SKSpriteNode(imageNamed: "earthDefenderlazerCircle")
        projectile.position = player.position
        
        projectile.zPosition = background.zPosition + 1
        projectile.xScale = 0.15
        projectile.yScale = 0.15
        
        
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2)
        projectile.physicsBody?.isDynamic = true
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.None
        projectile.physicsBody?.usesPreciseCollisionDetection = true
        
        // 3 - Determine offset of location to projectile
        let offset = touchLocation - projectile.position
        
        // 4 - Bail out if you are shooting down or backwards
        if (offset.y < size.height * 0.15) { return }
        
        // 5 - OK to add now - you've double checked position
        addChild(projectile)
        
        // 6 - Get the direction of where to shoot
        let direction = offset.normalized()
        
        // 7 - Make it shoot far enough to be guaranteed off screen
        let shootAmount = direction * 1000
        
        // 8 - Add the shoot amount to the current position
        let realDest = shootAmount + projectile.position
        
        // 9 - Create the actions
        let actionMove = SKAction.move(to: realDest, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    func projectileDidCollideWithMonster(projectile: SKSpriteNode, monster: SKSpriteNode) {
        print("Hit")
        projectile.removeFromParent()
        monster.removeFromParent()
        newPlayer.decrementMonstersLeft()
        newPlayer.incrementMonsterCount()
        self.monstersLeftLabel.text = "asteroids left: \(self.newPlayer.monstersLeftForLevel)"
        explosion(position: monster.position)
        if (newPlayer.monstersLeftForLevel == 0) {
            let levelService: LevelService = LevelService.sharedInstance
            levelService.incrementLevel()
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameScene = levelService.loadLevelComplete(size: self.size)
            self.view?.presentScene(gameScene, transition: reveal)
            
//            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
//            let gameOverScene = GameOverScene(size: self.size, won: true)
//            self.view?.presentScene(gameOverScene, transition: reveal)
            
        }
    }
    func didBegin(_ contact: SKPhysicsContact) {
        
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 2
        if ((firstBody.categoryBitMask & PhysicsCategory.Monster != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Projectile != 0)) {
            if let monster = firstBody.node as? SKSpriteNode, let
                projectile = secondBody.node as? SKSpriteNode {
                projectileDidCollideWithMonster(projectile: projectile, monster: monster)
                
            }
            
        }
        
    }
    
    
    func explosion(position: CGPoint) {
        if let particles = SKEmitterNode(fileNamed: "Explosion.sks") {
            particles.position = position
            particles.zPosition = background.zPosition + 1
            addChild(particles)
        }
    }
}

