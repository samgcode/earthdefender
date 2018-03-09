//
//  LevelCompleteScene.swift
//  EarthDefender
//
//  Created by Kids on 2017-03-18.
//  Copyright © 2017 Sam. All rights reserved.
//

import Foundation
import SpriteKit

class LevelCompleteScene: SKScene {
    
    var font = ThemeService.getfont()
    var levelNumberLabel: SKLabelNode = SKLabelNode()
    var monstersKilledLabel: SKLabelNode = SKLabelNode()
    var shotsBonusLabel: SKLabelNode = SKLabelNode()
    let background = SKSpriteNode(imageNamed: "LevelComplete")
    var player: Player = Player.sharedInstance
    var shotsFired: SKLabelNode = SKLabelNode()
    var scoreLabel: SKLabelNode = SKLabelNode()
    private let level: Int
    var monsterDifficulty: SKLabelNode = SKLabelNode()
    var monsterDifficulty2: SKLabelNode = SKLabelNode()
    
    
    init(size: CGSize, level: Int) {
        self.level = level
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func didMove(to view: SKView) {
        
        if player.LevelShotsFired == player.shotsBonus {
            shotsBonusLabel.text = "shot bonus: 100"
            player.bonusPoints += 100
        } else if player.LevelShotsFired < player.shotsBonus {
            shotsBonusLabel.text = "shot bonus: 50"
            player.bonusPoints += 50
        } else {
            shotsBonusLabel.text = "shot bonus: 0"
        }
        player.updateScore()

        if level == 10 || level == 20 {
            monsterDifficulty.text = "the next Monsters "
            monsterDifficulty2.text = "are more difficult!"
        } else {
            monsterDifficulty.text = ""
            monsterDifficulty2.text = ""
        }

        monsterDifficulty.position = CGPoint(x: size.width / 2, y: 630)
        monsterDifficulty.zPosition = 100
        monsterDifficulty.fontName = font
        monsterDifficulty.fontColor = UIColor.purple
        monsterDifficulty.fontSize = 25
        
        monsterDifficulty2.position = CGPoint(x: size.width / 2, y: 580)
        monsterDifficulty2.zPosition = 100
        monsterDifficulty2.fontName = font
        monsterDifficulty2.fontColor = UIColor.purple
        monsterDifficulty2.fontSize = 25

        
        shotsBonusLabel.position = CGPoint(x: size.width * 0.5, y: 500)
        shotsBonusLabel.zPosition = 100
        shotsBonusLabel.fontName = font
        shotsBonusLabel.fontColor = UIColor.green
        shotsBonusLabel.fontSize = 30
        
        background.aspectFillToSize(fillSize: (self.view?.frame.size)!)
        background.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        background.zPosition = 1
        
        scoreLabel.text = "score: \(player.score)"
        scoreLabel.zPosition = 100
        scoreLabel.position = CGPoint(x: 165, y: 100)
        scoreLabel.fontColor = UIColor.blue
        scoreLabel.fontSize = 30
        scoreLabel.fontName = font
        
        shotsFired.text = "shots fired: \(player._shotsFired)"
        shotsFired.zPosition = 100
        shotsFired.position = CGPoint(x: 165, y: 200)
        shotsFired.fontColor = UIColor.cyan
        shotsFired.fontSize = 30
        shotsFired.fontName = font
        
        levelNumberLabel.text = "Levels completed: \(level)"
        levelNumberLabel.zPosition = 100
        levelNumberLabel.position = CGPoint(x: 165, y: 400)
        levelNumberLabel.fontColor = UIColor.orange
        levelNumberLabel.fontSize = 30
        levelNumberLabel.fontName = font
        
        monstersKilledLabel.text = "monsters killed: \(player.totalMonstersKilled)"
        monstersKilledLabel.zPosition = 100
        monstersKilledLabel.position = CGPoint(x: 165, y: 300)
        monstersKilledLabel.fontColor = UIColor.red
        monstersKilledLabel.fontSize = 30
        monstersKilledLabel.fontName = font
        
        addChild(monsterDifficulty)
        addChild(monsterDifficulty2)
        addChild(shotsBonusLabel)
        addChild(scoreLabel)
        addChild(shotsFired)
        addChild(monstersKilledLabel)
        addChild(levelNumberLabel)
        addChild(background)
        fireWork(position: CGPoint(x: 100, y: 200))
        fireWork(position: CGPoint(x: 200, y: 400))
        fireWork(position: CGPoint(x: 100, y: 600))
        fireWork(position: CGPoint(x: 300, y: 500))
        
    }
   
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        showLevel()
    }

    func fireWork(position: CGPoint) {
        if let particles = SKEmitterNode(fileNamed: "FireWork.sks") {
            particles.position = position
            particles.zPosition = background.zPosition + 1
            addChild(particles)
        }
    }
    
    func showLevel() {
        let levelService: LevelService = LevelService.sharedInstance
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        let gameScene = levelService.loadNextLevel(size: size)
        self.view?.presentScene(gameScene, transition: reveal)
    }

}
