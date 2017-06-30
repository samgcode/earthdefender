//
//  MonsterType.swift
//  EarthDefender
//
//  Created by Kids on 2017-05-07.
//  Copyright © 2017 Sam. All rights reserved.
//

import Foundation

enum MonsterType: Int {
    case commet
    case asteroid
    case spaceship
    case spaceship2
    case commetBoss
    case asteroidBoss
}

func fileName(for monsterType: MonsterType) -> String {
    switch monsterType {
    case .commet: return "EarthDefenderasteroid"
    case .asteroid: return "EarthDefenderAsteroid2"
    case .spaceship: return "EarthDefenderAsteroid3"
    case .spaceship2: return "EarthDefenderSpaceship2"
    case .commetBoss: return "EarthDefenderCommetBoss"
    case .asteroidBoss: return "EarthDefenderAsteroid2"
    }
}

func getLives(for monsterType: MonsterType) -> Int {
    switch monsterType {
    case .commet: return 1
    case .asteroid: return 1
    case .spaceship: return 2
    case .spaceship2: return 2
    case .commetBoss: return 15
    case .asteroidBoss: return 20
    }
}

func getSpeed(for monsterType: MonsterType) -> Double {
    switch monsterType {
    case .commet: return 7.0
    case .asteroid: return 6.0
    case .spaceship: return 5.0
    case .spaceship2: return 4.0
    case .commetBoss: return 8.0
    case .asteroidBoss: return 8.5
    }
}
