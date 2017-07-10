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
    var background = SKSpriteNode(imageNamed: "EarthDefenderGameCompleteScene")
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        background.zPosition = 1
        background.xScale = 0.90
        background.yScale = 1.20
        
        addChild(background)
    }
    
}
