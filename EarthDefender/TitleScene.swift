//
//  TitleScene.swift
//  spritekitsimplegame
//
//  Created by Kids on 2017-03-12.
//  Copyright © 2017 kinguine anamations. All rights reserved.
//

import Foundation
import SpriteKit

class TitleScene: SKScene {
    
     let background = SKSpriteNode(imageNamed: "EarthDefenderTitleScreen")
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        background.zPosition = 1
        background.xScale = 0.95
        background.yScale = 1.35
        
        addChild(background)
    }
    
    func showLevel() {
        let levelService: LevelService = LevelService.sharedInstance
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        let gameScene = levelService.loadNextLevel(size: self.size)
        self.view?.presentScene(gameScene, transition: reveal)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        showLevel()
    }
}
