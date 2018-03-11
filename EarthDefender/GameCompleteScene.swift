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
    var line1: SKLabelNode = SKLabelNode()
    var line2: SKLabelNode = SKLabelNode()
    var line3: SKLabelNode = SKLabelNode()
    
    
    override func didMove(to view: SKView) {
        let backgroundImage = FileNameRetriever.imageFileName(fileName: "GameComplete")
        let background = SKSpriteNode(imageNamed: backgroundImage)
        background.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        background.zPosition = 1

        let center = ThemeService.screenCenter(size: size.width)

        
        line1.text = "Congrats you beat"
        line1.position = CGPoint(x: center, y: 450)
        line1.zPosition = 100
        line1.fontSize = 30
        line1.fontName = font
        line1.fontColor = UIColor.blue
        
        line2.text = "the game ... "
        line2.position = CGPoint(x: center, y: 400)
        line2.zPosition = 100
        line2.fontSize = 30
        line2.fontName = font
        line2.fontColor = UIColor.blue
        
        line3.text = "now go outside!"
        line3.position = CGPoint(x: center, y: 350)
        line3.zPosition = 100
        line3.fontSize = 30
        line3.fontName = font
        line3.fontColor = UIColor.blue
        
        scoreLabel.text = "Score: \(player.score)"
        scoreLabel.zPosition = 100
        scoreLabel.position = CGPoint(x: center, y: 50)
        scoreLabel.fontColor = UIColor.blue
        scoreLabel.fontSize = 30
        scoreLabel.fontName = font
        
        shotsFired.text = "Shots fired: \(player._shotsFired)"
        shotsFired.zPosition = 100
        shotsFired.position = CGPoint(x: center, y: 100)
        shotsFired.fontColor = UIColor.cyan
        shotsFired.fontSize = 30
        shotsFired.fontName = font
        
        monstersKilledLabel.position = CGPoint(x: center, y: 200)
        monstersKilledLabel.zPosition = 100
        monstersKilledLabel.text = "Enemies Killed: \(player.totalMonstersKilled)"
        monstersKilledLabel.fontSize = 25
        monstersKilledLabel.fontColor = UIColor.cyan
        monstersKilledLabel.fontName = font
        
        levelsBeatLabel.position = CGPoint(x: center, y: 150)
        levelsBeatLabel.zPosition = 100
        levelsBeatLabel.text = "Levels Completed \(levelService.currentLevel - 1)"
        levelsBeatLabel.fontSize = 25
        levelsBeatLabel.fontColor = UIColor.orange
        levelsBeatLabel.fontName = font
        
        addChild(line1)
        addChild(line2)
        addChild(line3)
        addChild(scoreLabel)
        addChild(shotsFired)
        addChild(levelsBeatLabel)
        addChild(monstersKilledLabel)
        addChild(background)
    }
    
}
