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
    var monsterCount: Int
    var player: Player = Player.sharedInstance
    
    init() {
        self.currentLevel = 0
        monsterCount = 0
    }
    
    
    func loadTitleScene(size: CGSize) -> SKScene {
        return TitleScene(size: size)
    }
    
    func loadNextLevel(size: CGSize) -> SKScene {
        currentLevel += 1
        player.incrementLives()
        
        if (currentLevel == 1 || currentLevel == 2 || currentLevel == 3 || currentLevel == 4) {
            return GameScene.init(monster: .commet, size: size, numberOfMonsters: monsterAmount(), backgroundType: .earth)
        } else if currentLevel == 5{
            return Level2.init(monster: .commet, size: size, backgroundType: .earth, boss: .commetBoss)
        } else if (currentLevel == 6 || currentLevel == 7 || currentLevel == 8 || currentLevel == 9) {
            return GameScene.init(monster: .asteroid, size: size, numberOfMonsters: monsterAmount(), backgroundType: .earth)
        } else if currentLevel == 10 {
            return Level2.init(monster: .asteroid, size: size, backgroundType: .earth, boss: .asteroidBoss)
        } else if (currentLevel == 11 || currentLevel == 12 || currentLevel == 13 || currentLevel == 14) {
            return GameScene.init(monster: .spaceship, size: size, numberOfMonsters: monsterAmount(), backgroundType: .mars)
        } else if currentLevel == 15 {
            return Level2.init(monster: .spaceship, size: size, backgroundType: .mars, boss: .spaceshipBoss1)
        } else if (currentLevel == 16 || currentLevel == 17 || currentLevel == 18 || currentLevel == 19) {
            return GameScene.init(monster: .spaceship2, size: size, numberOfMonsters: monsterAmount(), backgroundType: .mars)
        } else if currentLevel == 20 {
            return Level2.init(monster: .spaceship2, size: size, backgroundType: .mars, boss: .spaceshipBoss2)
        } else {
            return GameScene.init(monster: .commet, size: size, numberOfMonsters: monsterAmount(), backgroundType: .earth)
      }
   
    }
    
    func loadLevelComplete(size: CGSize) -> SKScene {
        return LevelCompleteScene(size: size, level: currentLevel)
    }
    func monsterAmount() -> Int {
        if (currentLevel == 1 || currentLevel == 2 || currentLevel == 3 || currentLevel == 4) {
            monsterCount = currentLevel * 5
            monsterCount += 20
            return monsterCount
        } else if (currentLevel == 6 || currentLevel == 7 || currentLevel == 8 || currentLevel == 9) {
            monsterCount = currentLevel * 5
            monsterCount -= 5
            return monsterCount
        } else if (currentLevel == 11 || currentLevel == 12 || currentLevel == 13 || currentLevel == 14){
            monsterCount = currentLevel * 5
            monsterCount -= 30
            return monsterCount
        } else if (currentLevel == 16 || currentLevel == 17 || currentLevel == 18 || currentLevel == 19) {
            monsterCount = currentLevel * 5
            monsterCount -= 55
            return monsterCount
        } else {
            return 0
        }
    }
    
    func resetCurrentLevel() {
        currentLevel = 0
    }
}












