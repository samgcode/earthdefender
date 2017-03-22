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

    let background = SKSpriteNode(imageNamed: "EarthDefenderLevelCompleteScene")
    

    
    override func didMove(to view: SKView) {
       background.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        background.zPosition = 1
        background.xScale = 1.10
        background.yScale = 1.60
    
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
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        let gameScene = Level2(size: self.size)
        self.view?.presentScene(gameScene, transition: reveal)
    }

}
