//
//  LevelSurvice.swift
//  EarthDefender
//
//  Created by Kids on 2017-04-02.
//  Copyright © 2017 Sam. All rights reserved.
//

import Foundation
import SpriteKit

class LevelService {
    static let sharedInstance = LevelService()
    private(set) var curentLevel: Int
    
    init() {
        self.curentLevel = 0
    }
    
    
    func loadTitleScene(size: CGSize) -> SKScene {
        return TitleScene(size: size)
    }
    
    func loadNextLevel(size: CGSize) -> SKScene {
        curentLevel += 1

        if curentLevel == 2 {
            return GameScene.init(monster: .asteroid, size: size, numberOfMonsters: 30)
        } else if curentLevel == 3 {
            return GameScene.init(monster: .spaceship, size: size, numberOfMonsters: 35)
        } else {
        return GameScene.init(monster: .commet, size: size, numberOfMonsters: 25)
      }
    }
    func loadLevelComplete(size: CGSize) -> SKScene {
        return LevelCompleteScene(size: size, level: curentLevel)
    }
}
