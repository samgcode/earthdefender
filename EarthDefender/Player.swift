//
//  player.swift
//  EarthDefender
//
//  Created by Kids on 2017-03-20.
//  Copyright © 2017 Sam. All rights reserved.
//

import Foundation

class Player {
    
    private(set) var lives: Int
    private(set) var totalMonstersKilled: Int
    var monstersLeftForLevel: Int
    var _shotsFired: Int
    var score: Int
    var LevelShotsFired: Int
    var shotsBonus: Int
    var bonusPoints: Int
    
    static let sharedInstance = Player()
    
    init() {
        self.lives = 4
        self.totalMonstersKilled = 0
        self.monstersLeftForLevel = 25
        self._shotsFired = 0
        self.score = 0
        self.LevelShotsFired = 0
        self.shotsBonus = 0
        self.bonusPoints = 0
    }
    
    func incrementMonsterCount() {
        totalMonstersKilled += 1
    }
    
    func decrementLives() {
        lives -= 1
    }
    
    func decrementMonstersLeft() {
        monstersLeftForLevel -= 1
    }
    
    func incrementLives() {
        lives += 1
    }

    func kill() {
       lives -= lives
    }
    
    func incrementShotsFired() {
        _shotsFired += 1
    }
    
    func updateScore() {
        score = lives * 5 + totalMonstersKilled - _shotsFired / 4 + bonusPoints
    }
    
    func resetPlayer() {
        lives = 9
        totalMonstersKilled = 0
        _shotsFired = 0
    }
    
}














