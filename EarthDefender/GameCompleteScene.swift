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
    
    var font = ThemeService.getfont()
    
    let player: Player = Player.sharedInstance
    let levelService: LevelService = LevelService.sharedInstance
    let monstersKilledLabel: SKLabelNode = SKLabelNode()
    let levelsBeatLabel: SKLabelNode = SKLabelNode()
    var shotsFired: SKLabelNode = SKLabelNode()
    var scoreLabel: SKLabelNode = SKLabelNode()
    
    override func didMove(to view: SKView) {
        let backgroundImage = FileNameRetriever.imageFileName(fileName: "GameComplete")
        let background = SKSpriteNode(imageNamed: backgroundImage)
        background.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        background.zPosition = 1

        scoreLabel.text = "score: \(player.score)"
        scoreLabel.zPosition = 100
        scoreLabel.position = CGPoint(x: 165, y: 50)
        scoreLabel.fontColor = UIColor.blue
        scoreLabel.fontSize = 30
        scoreLabel.fontName = font
        
        shotsFired.text = "shots fired: \(player._shotsFired)"
        shotsFired.zPosition = 100
        shotsFired.position = CGPoint(x: 165, y: 100)
        shotsFired.fontColor = UIColor.cyan
        shotsFired.fontSize = 30
        shotsFired.fontName = font
        
        monstersKilledLabel.position = CGPoint(x: 155, y: 200)
        monstersKilledLabel.zPosition = 100
        monstersKilledLabel.text = "Monsters Killed: \(player.totalMonstersKilled)"
        monstersKilledLabel.fontSize = 25
        monstersKilledLabel.fontColor = UIColor.cyan
        monstersKilledLabel.fontName = font
        
        levelsBeatLabel.position = CGPoint(x: 155, y: 150)
        levelsBeatLabel.zPosition = 100
        levelsBeatLabel.text = "Levels Completed \(levelService.currentLevel - 1)"
        levelsBeatLabel.fontSize = 25
        levelsBeatLabel.fontColor = UIColor.orange
        levelsBeatLabel.fontName = font
        
        addChild(scoreLabel)
        addChild(shotsFired)
        addChild(levelsBeatLabel)
        addChild(monstersKilledLabel)
        addChild(background)
    }
    
}
