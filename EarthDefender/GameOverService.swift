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
        let level: Int
        var monstersKilled: Int
    
    init() {
        level = levelService.curentLevel
        monstersKilled = player.totalMonstersKilled
    }
    
    func resetCouters() {
        levelService.resetCurentLevel()
        player.resetPlayer()
    }
    
    func loadGameOverScene(size: CGSize) -> SKScene {
        return GameOverScene.init(size: size, level: level)
    }

}
