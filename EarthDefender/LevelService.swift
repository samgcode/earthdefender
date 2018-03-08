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
        var shotBonus = 25
        switch currentLevel {
        case 1, 2, 3, 4:
            monsterCount = currentLevel * 5 + 20
            shotBonus = currentLevel * 5 + 30
        case 5:
            return Level2.init(monster: .commet, size: size, backgroundType: .earth, boss: .commetBoss, shotBonus: 25)
        case 6, 7, 8, 9:
            monsterType = .asteroid
            monsterCount = currentLevel * 5 - 5
            backgroundType = .earth
            shotBonus = currentLevel * 5 + 5
        case 10:
            return Level2.init(monster: .asteroid, size: size, backgroundType: .earth, boss: .asteroidBoss, shotBonus: 30)
        case 11, 12, 13, 14:
            monsterType = .spaceship
            monsterCount = currentLevel * 5 - 30
            backgroundType = .mars
            shotBonus = currentLevel * 5 - 20
            shotBonus = shotBonus * 2
        case 15:
            return Level2.init(monster: .spaceship, size: size, backgroundType: .mars, boss: .spaceshipBoss1, shotBonus: 33)
        case 16, 17, 18, 19:
            monsterType = .spaceship2
            monsterCount = currentLevel * 5 - 55
            backgroundType = .mars
            shotBonus = currentLevel * 5 - 45
            shotBonus = shotBonus * 2
        case 20:
            return Level2.init(monster: .spaceship2, size: size, backgroundType: .mars, boss: .spaceshipBoss2, shotBonus: 35)
        case 21, 22, 23, 24:
            monsterType = .alien
            monsterCount = currentLevel * 5 - 80
            backgroundType = .pluto
            shotBonus = currentLevel * 5 - 70
            shotBonus = shotBonus * 3
        case 25:
            return Level2.init(monster: .alien, size: size, backgroundType: .pluto, boss: .alienBoss, shotBonus: 39)
        case 26, 27, 28, 29:
           monsterType = .alien2
           monsterCount = currentLevel * 5 - 105
           backgroundType = .pluto
           shotBonus = currentLevel * 5 - 95
            shotBonus = shotBonus * 3
        case 30:
            return Level2.init(monster: .alien2, size: size, backgroundType: .pluto, boss: .alienBoss, shotBonus: 38)
        case 31, 32, 33, 34:
            monsterType = .spaceship3
            monsterCount = currentLevel * 5 - 130
            backgroundType = .pluto
            shotBonus = currentLevel * 5 - 120
            shotBonus = shotBonus * 3
        case 35:
            return Level2.init(monster: .alien2, size: size, backgroundType: .pluto, boss: .spaceshipBoss3, shotBonus: 40)
        case 36:
            return GameCompleteScene.init(size: size)
        default:
            return GameScene.init(monster: monsterType, size: size, numberOfMonsters: monsterCount, backgroundType: backgroundType, shotBonus: shotBonus)
        }
        return GameScene.init(monster: monsterType, size: size, numberOfMonsters: monsterCount, backgroundType: backgroundType, shotBonus: shotBonus)
    }
    
    func loadLevelComplete(size: CGSize) -> SKScene {
        return LevelCompleteScene(size: size, level: currentLevel)
    }
    
    func resetCurrentLevel() {
        currentLevel = 0
    }
}












