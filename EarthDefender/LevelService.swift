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
    private(set) var currentLevel: Int
    var player: Player = Player.sharedInstance
    
    init() {
        self.currentLevel = 0
    }
    
    func loadTitleScene(size: CGSize) -> SKScene {
        return TitleScene(size: size)
    }
    
    func loadNextLevel(size: CGSize) -> SKScene {
        currentLevel += 1
        player.incrementLives()
        var monsterType: MonsterType = .commet
        var monsterCount = 25
        var backgroundType: BackgroundType = .earth
        
        switch currentLevel {
        case 1, 2, 3, 4:
            monsterCount = currentLevel * 5 + 20
        case 5:
            return Level2.init(monster: .commet, size: size, backgroundType: .earth, boss: .commetBoss)
        case 6, 7, 8, 9:
            monsterType = .asteroid
            monsterCount = currentLevel * 5 - 5
            backgroundType = .earth
        case 10:
            return Level2.init(monster: .asteroid, size: size, backgroundType: .earth, boss: .asteroidBoss)
        case 11, 12, 13, 14:
            monsterType = .spaceship
            monsterCount = currentLevel * 5 - 30
            backgroundType = .mars
        case 15:
            return Level2.init(monster: .spaceship, size: size, backgroundType: .mars, boss: .spaceshipBoss1)
        case 16, 17, 18, 19:
            monsterType = .spaceship2
            monsterCount = currentLevel * 5 - 55
            backgroundType = .mars
        case 20:
            return Level2.init(monster: .spaceship2, size: size, backgroundType: .mars, boss: .spaceshipBoss2)
        case 21:
            return GameCompleteScene.init(size: size)
        default:
            return GameScene.init(monster: monsterType, size: size, numberOfMonsters: monsterCount, backgroundType: backgroundType)
        }
        return GameScene.init(monster: monsterType, size: size, numberOfMonsters: monsterCount, backgroundType: backgroundType)
    }
    
    func loadLevelComplete(size: CGSize) -> SKScene {
        return LevelCompleteScene(size: size, level: currentLevel)
    }
    
    func resetCurrentLevel() {
        currentLevel = 0
    }
}












