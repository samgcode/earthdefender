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
    let clickToStartLabel: SKLabelNode = SKLabelNode()
    let creditsSprite = SKSpriteNode(imageNamed: "earthDefenderbutton")
    let CREDITS_SPRITE_NAME = "CREDITS_SPRITE_NAME"
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        background.zPosition = 1
        background.xScale = 0.95
        background.yScale = 1.35
//        background.aspectFillToSize(fillSize: (self.view?.frame.size)!)
        
        clickToStartLabel.position = CGPoint(x: 150, y: 140)
        clickToStartLabel.zPosition = 100
        clickToStartLabel.text = "tap to start"
        clickToStartLabel.fontColor = UIColor.blue
        clickToStartLabel.fontSize = 35
        clickToStartLabel.fontName = "AmericanTypewriter"
        
        creditsSprite.xScale = 0.4
        creditsSprite.yScale = 0.4
        creditsSprite.position = CGPoint(x: size.width * 0.5, y: 500)
        creditsSprite.zPosition = background.zPosition + 1
        creditsSprite.name = CREDITS_SPRITE_NAME
        
        addChild(clickToStartLabel)
        addChild(background)
        addChild(creditsSprite)
    }
    
    func showLevel() {
        let levelService: LevelService = LevelService.sharedInstance
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        let gameScene = levelService.loadNextLevel(size: self.size)
        self.view?.presentScene(gameScene, transition: reveal)
    }
    
    func showCredits(){
        var vc: UIViewController = UIViewController()
        vc = self.view!.window!.rootViewController!
        vc.performSegue(withIdentifier: "GameViewToNavController", sender: vc)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            if let name = touchedNode.name {
                if name == CREDITS_SPRITE_NAME {
                    showCredits()
                }
            }
            else {
                showLevel()
            }
        }
    }
}
