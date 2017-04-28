//
//  monster.swift
//  EarthDefender
//
//  Created by Kids on 2017-04-01.
//  Copyright © 2017 Sam. All rights reserved.
//

import Foundation
import SpriteKit

class Monster: SKSpriteNode {
    
    private (set) var lives: Int
    var player: Player = Player.sharedInstance
    
    init (position: CGPoint, spriteName: String) {
        self.lives = 1
        let texture = SKTexture(imageNamed: spriteName)
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        let monster = self
        monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size) // 1
        monster.physicsBody?.isDynamic = true // 2
        monster.physicsBody?.categoryBitMask = ScenePhysicsCategory.Monster // 3
        monster.physicsBody?.contactTestBitMask = ScenePhysicsCategory.Projectile // 4
        monster.physicsBody?.collisionBitMask = ScenePhysicsCategory.None // 5
        
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        monster.position = CGPoint(x: position.x, y: position.y)
        
        monster.xScale = 0.3
        monster.yScale = 0.3
        
//        if lives <= 0 {
//            player.decrementMonstersLeft()
//            player.incrementMonsterCount()
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func decrementLives() {
        lives -= 1
    }
    
}























