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
}

func fileName(for monsterType: MonsterType) -> String {
    switch monsterType {
    case .commet: return "EarthDefenderasteroid"
    case .asteroid: return "EarthDefenderAsteroid2"
    case .spaceship: return "EarthDefenderAsteroid3"
    }
}

func getLives(for monsterType: MonsterType) -> Int {
    switch monsterType {
    case .commet: return 1
    case .asteroid: return 1
    case .spaceship: return 2
    }
}

func getSpeed(for monsterType: MonsterType) -> Double {
    switch monsterType {
    case .commet: return 5.0
    case .asteroid: return 6.0
    case .spaceship: return 7.0
    }
}
