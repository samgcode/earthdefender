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
    let background = SKSpriteNode(imageNamed: "EarthDefenderLevelCompleteBackground")
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
        background.xScale = 1.14
        background.yScale = 1.64
        
        levelNumberLabel.text = " You have copleted level:\(level)"
        levelNumberLabel.zPosition = 100
        levelNumberLabel.position = CGPoint(x: 165, y: 400)
        levelNumberLabel.fontColor = UIColor.yellow
        levelNumberLabel.fontSize = 25
        levelNumberLabel.fontName = "AmericanTypewriter"
        
        monstersKilledLabel.text = "monsters killed: \(player.totalMonstersKilled)"
        monstersKilledLabel.zPosition = 100
        monstersKilledLabel.position = CGPoint(x: 165, y: 300)
        monstersKilledLabel.fontColor = UIColor.red
        monstersKilledLabel.fontSize = 30
        monstersKilledLabel.fontName = "AmericanTypewriter"
        
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
