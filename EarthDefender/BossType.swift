//
//  BossType.swift
//  EarthDefender
//
//  Created by Kids on 2017-06-18.
//  Copyright © 2017 Sam. All rights reserved.
//

import Foundation

enum BossType: Int {
    case commetBoss
    case asteroidBoss
    
}

func fileName(for bossType: BossType) -> String {
    switch bossType {
    case .commetBoss: return "EarthDefenderCommetBoss"
    case .asteroidBoss: return "EarthDefenderAsteroid2"
    }
}

func getLives(for bossType: BossType) -> Int {
    switch bossType {
    case .commetBoss: return 20
    case .asteroidBoss: return 30
    }
}
