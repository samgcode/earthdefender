//
//  GameOverService.swift
//  EarthDefender
//
//  Created by Kids on 2017-07-08.
//  Copyright © 2017 Sam. All rights reserved.
//

import SpriteKit
import Foundation

class GameOverService {
        static let sharedInstance = GameOverService()
        let levelService: LevelService = LevelService.sharedInstance
        let player: Player = Player.sharedInstance
    
    func resetCouters() {
        //reset current level
        //reset player lives
        //reset total monsters
    }
    
    func loadGameOverScene(size: CGSize) -> SKScene {
        return GameOverScene.init(size: size, level: levelService.curentLevel)
    }

}
