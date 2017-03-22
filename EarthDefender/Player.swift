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
    
    init(lives: Int) {
        self.lives = lives
        self.totalMonstersKilled = 0
        self.monstersLeftForLevel = 25
    }
    
    func incrumentMonsterCount() {
        totalMonstersKilled += 1
    }
    
    func decrementLives() {
        lives -= 1
    }
    
    func decrementMonstersLeft() {
        monstersLeftForLevel -= 1
    }

}
