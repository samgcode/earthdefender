//
//  Level2.swift
//  EarthDefender
//
//  Created by Kids on 2017-03-21.
//  Copyright © 2017 Sam. All rights reserved.
//

import Foundation
import SpriteKit

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(a)))
    }
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}


class Level2: SKScene, SKPhysicsContactDelegate {
    var player: Player = Player.sharedInstance
    let background: SKSpriteNode
    private (set) var monsterType: MonsterType
    private (set) var numberOfMonsters: Int
    private (set) var bossType: MonsterType
    
    init(monster: MonsterType, size: CGSize, numberOfMonsters: Int, backgroundType: BackgroundType, boss: MonsterType) {
        monsterType = monster
        bossType = boss
        self.numberOfMonsters = numberOfMonsters
        self.background = SKSpriteNode(imageNamed: fileName(for: backgroundType))
        background.xScale = xSize(for: backgroundType)
        background.yScale = ySize(for: backgroundType)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 1
    let playerSprite = SKSpriteNode(imageNamed: "earthDefenderSataliteSprite")
    let livesLabel: SKLabelNode = SKLabelNode()
    let monstersLeftLabel: SKLabelNode = SKLabelNode()
    
    
    override func didMove(to view: SKView) {
        
        player.monstersLeftForLevel = 25
        
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        // 2
        backgroundColor = SKColor.white
        // 3
        playerSprite.xScale = 0.4
        playerSprite.yScale = 0.4
        
        
        background.position = CGPoint(x: size.width * 0.3, y: size.height * 0.5)
        background.zPosition = 1
        
        playerSprite.position = CGPoint(x: size.width * 0.5, y: size.height * 0.18)
        playerSprite.zPosition = background.zPosition + 1
        // 4
        
        livesLabel.position = CGPoint(x: 70, y: 630)
        livesLabel.zPosition = 100
        livesLabel.text = "lives: \(player.lives)"
        livesLabel.fontColor = UIColor.red
        livesLabel.fontSize = 25
        
//        monstersLeftLabel.position = CGPoint(x: 270, y: 630)
//        monstersLeftLabel.zPosition = 100
//        monstersLeftLabel.text = "asteroids left: \(numberOfMonsters)"
//        monstersLeftLabel.fontColor = UIColor.green
//        monstersLeftLabel.fontSize = 25
        
        addChild(background)
        addChild(playerSprite)
        addChild(livesLabel)
        addChild(monstersLeftLabel)
        addBoss()
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addMonster),
                SKAction.wait(forDuration: 2.0)
                ])
        ))
        let backgroundMusic = SKAudioNode(fileNamed: "BackgroundMusic.aac")
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
        let actualY = size.height
        let actualX = random(min: 1, max: 350)
        let monsterNode = Monster.init(position: CGPoint(x: actualX, y: actualY), monsterType: monsterType)
        monsterNode.zPosition = background.zPosition + 1
        
        // Add the monster to the scene
        addChild(monsterNode)
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(7.0), max: CGFloat(getSpeed(for: monsterType)))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: actualY - actualY), duration: TimeInterval(actualDuration))
        
        let actionMoveDone = SKAction.removeFromParent()
        
        let loseAction = SKAction.run() {
            self.player.decrementLives()
            self.livesLabel.text = "lives: \(self.player.lives)"
            
            
            
            if self.player.lives <= 0 {
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = GameOverScene(size: self.size)
                self.view?.presentScene(gameScene, transition: reveal)
            }
        }
        monsterNode.run(SKAction.sequence([actionMove, loseAction, actionMoveDone]))
    }
    
    func addBoss() {
        let actualY = size.height
        let actualX = size.width / 2
        let monsterNode = Monster.init(position: CGPoint(x: actualX, y: actualY), monsterType: bossType)
        monsterNode.zPosition = background.zPosition + 1
        
        // Add the monster to the scene
        addChild(monsterNode)
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(8.0), max: CGFloat(getSpeed(for: bossType)))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: actualY - actualY), duration: TimeInterval(actualDuration))
        
        let actionMoveDone = SKAction.removeFromParent()
        
        let loseAction = SKAction.run() {
            self.player.decrementLives()
            self.livesLabel.text = "lives: \(self.player.lives)"
            
            
            
            if self.player.lives <= 0 {
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = GameOverScene(size: self.size)
                self.view?.presentScene(gameScene, transition: reveal)
            }
        }
        monsterNode.run(SKAction.sequence([actionMove, loseAction, actionMoveDone]))
    }

   
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        run(SKAction.playSoundFileNamed("lazersound.m4a", waitForCompletion: false))
        
        // 1 - Choose one of the touches to work with
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        // 2 - Set up initial location of projectile
        let projectile = SKSpriteNode(imageNamed: "earthDefenderlazerCircle")
        projectile.position = playerSprite.position
        
        projectile.zPosition = background.zPosition + 1
        projectile.xScale = 0.15
        projectile.yScale = 0.15
        
        
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2)
        projectile.physicsBody?.isDynamic = true
        projectile.physicsBody?.categoryBitMask = ScenePhysicsCategory.Projectile
        projectile.physicsBody?.contactTestBitMask = ScenePhysicsCategory.Monster
        projectile.physicsBody?.collisionBitMask = ScenePhysicsCategory.None
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
    
    func projectileDidCollideWithMonster(projectile: SKSpriteNode, monster: Monster) {
        monster.decrementLives()
        projectile.removeFromParent()
        explosion(position: monster.position)
        
        
        if monster.lives <= 0 {
            monster.removeFromParent()
            player.incrementMonsterCount()
            numberOfMonsters -= 1
            self.monstersLeftLabel.text = "asteroids left: \(numberOfMonsters)"
        }
        
        if (numberOfMonsters == 0) {
            let levelService: LevelService = LevelService.sharedInstance
            
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameScene = levelService.loadLevelComplete(size: self.size)
            self.view?.presentScene(gameScene, transition: reveal)
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
        if ((firstBody.categoryBitMask & ScenePhysicsCategory.Monster != 0) &&
            (secondBody.categoryBitMask & ScenePhysicsCategory.Projectile != 0)) {
            if let monster = firstBody.node as? Monster, let
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
