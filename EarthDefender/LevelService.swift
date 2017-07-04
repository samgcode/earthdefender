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
    var monsterCount: Int
    var player: Player = Player.sharedInstance
    
    init() {
        self.curentLevel = 0
        monsterCount = 0
    }
    
    
    func loadTitleScene(size: CGSize) -> SKScene {
        return TitleScene(size: size)
    }
    
    func loadNextLevel(size: CGSize) -> SKScene {
        curentLevel += 1
        player.incrementLives()
        
        if (curentLevel == 1 || curentLevel == 2 || curentLevel == 3 || curentLevel == 4) {
            return GameScene.init(monster: .commet, size: size, numberOfMonsters: monsterAmount(), backgroundType: .earth)
        } else if curentLevel == 5{
            return Level2.init(monster: .commet, size: size, backgroundType: .earth, boss: .commetBoss)
        } else if (curentLevel == 6 || curentLevel == 7 || curentLevel == 8 || curentLevel == 9) {
            return GameScene.init(monster: .asteroid, size: size, numberOfMonsters: monsterAmount(), backgroundType: .earth)
        } else if curentLevel == 10 {
            return Level2.init(monster: .asteroid, size: size, backgroundType: .earth, boss: .asteroidBoss)
        } else if (curentLevel == 11 || curentLevel == 12 || curentLevel == 13 || curentLevel == 14) {
            return GameScene.init(monster: .spaceship, size: size, numberOfMonsters: monsterAmount(), backgroundType: .mars)
        } else if curentLevel == 15 {
            return Level2.init(monster: .spaceship, size: size, backgroundType: .mars, boss: .spaceshipBoss1)
        } else if (curentLevel == 16 || curentLevel == 17 || curentLevel == 18 || curentLevel == 19) {
            return GameScene.init(monster: .spaceship2, size: size, numberOfMonsters: monsterAmount(), backgroundType: .mars)
        } else if curentLevel == 20 {
            return Level2.init(monster: .spaceship2, size: size, backgroundType: .mars, boss: .spaceshipBoss2)
        } else {
            return GameScene.init(monster: .commet, size: size, numberOfMonsters: monsterAmount(), backgroundType: .earth)
      }
   
    }
    
    func loadLevelComplete(size: CGSize) -> SKScene {
        return LevelCompleteScene(size: size, level: curentLevel)
    }
    func monsterAmount() -> Int {
        if (curentLevel == 1 || curentLevel == 2 || curentLevel == 3 || curentLevel == 4) {
            monsterCount = curentLevel * 5
            monsterCount += 20
            return 1
            
        } else if (curentLevel == 6 || curentLevel == 7 || curentLevel == 8 || curentLevel == 9) {
            monsterCount = curentLevel * 5
            monsterCount -= 5
            return monsterCount
        } else if (curentLevel == 11 || curentLevel == 12 || curentLevel == 13 || curentLevel == 14){
            monsterCount = curentLevel * 5
            monsterCount -= 30
            return monsterCount
        } else if (curentLevel == 16 || curentLevel == 17 || curentLevel == 18 || curentLevel == 19) {
            monsterCount = curentLevel * 5
            monsterCount -= 55
            return monsterCount
        } else {
            return 0
        }
    }
}












