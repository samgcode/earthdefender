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
        
        func fireWork(position: CGPoint) {
            if let particles = SKEmitterNode(fileNamed: "FireWork.sks") {
                particles.position = position
                particles.zPosition = background.zPosition + 1
                addChild(particles)
            }
        }
    }
}
