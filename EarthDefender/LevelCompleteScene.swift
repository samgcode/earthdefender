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

    var levelNumberLabel: SKLabelNode = SKLabelNode()
    var monstersKilledLabel: SKLabelNode = SKLabelNode()
    let background = SKSpriteNode(imageNamed: "EarthDefenderLevelCompleteScene")
    var player: Player = Player.sharedInstance
    private let level: Int
    
    init(size: CGSize, level: Int) {
        self.level = level
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        background.zPosition = 1
        background.xScale = 1.10
        background.yScale = 1.60
        
        levelNumberLabel.text = "\(level)"
        levelNumberLabel.zPosition = 100
        levelNumberLabel.position = CGPoint(x: 110, y: 70)
        levelNumberLabel.fontColor = UIColor.yellow
        levelNumberLabel.fontSize = 50
        
        monstersKilledLabel.text = "monsters killed: \(player.totalMonstersKilled)"
        monstersKilledLabel.zPosition = 100
        monstersKilledLabel.position = CGPoint(x: 180, y: 300)
        monstersKilledLabel.fontColor = UIColor.red
        monstersKilledLabel.fontSize = 45
    
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
