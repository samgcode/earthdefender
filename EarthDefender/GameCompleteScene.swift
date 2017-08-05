//
//  GameCompleteScene.swift
//  EarthDefender
//
//  Created by Kids on 2017-07-10.
//  Copyright © 2017 Sam. All rights reserved.
//

import Foundation
import SpriteKit

class GameCompleteScene: SKScene {
    let player: Player = Player.sharedInstance
    let levelService: LevelService = LevelService.sharedInstance
    let background = SKSpriteNode(imageNamed: "EarthDefenderGameCompleteScene")
    let monstersKilledLabel: SKLabelNode = SKLabelNode()
    let levelsBeatLabel: SKLabelNode = SKLabelNode()
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        background.zPosition = 1
        background.xScale = 0.90
        background.yScale = 1.20
        
        monstersKilledLabel.position = CGPoint(x: 155, y: 200)
        monstersKilledLabel.zPosition = 100
        monstersKilledLabel.text = "Monsters Killed: \(player.totalMonstersKilled)"
        monstersKilledLabel.fontSize = 25
        monstersKilledLabel.fontColor = UIColor.cyan
        monstersKilledLabel.fontName = "AmericanTypewriter"
        
        levelsBeatLabel.position = CGPoint(x: 155, y: 150)
        levelsBeatLabel.zPosition = 100
        levelsBeatLabel.text = "Levels Completed \(levelService.currentLevel - 1)"
        levelsBeatLabel.fontSize = 25
        levelsBeatLabel.fontColor = UIColor.orange
        levelsBeatLabel.fontName = "AmericanTypewriter"
        
        addChild(levelsBeatLabel)
        addChild(monstersKilledLabel)
        addChild(background)
    }
    
}
