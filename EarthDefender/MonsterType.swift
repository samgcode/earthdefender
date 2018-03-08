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
    case spaceship3
    case alien
    case alien2
    case commetBoss
    case asteroidBoss
    case spaceshipBoss1
    case spaceshipBoss2
    case alienBoss
    case spaceshipBoss3
}

func fileName(for monsterType: MonsterType) -> String {
    switch monsterType {
    case .commet: return "EarthDefenderasteroid"
    case .asteroid: return "EarthDefenderAsteroid2"
    case .spaceship: return "EarthDefenderAsteroid3"
    case .spaceship2: return "EarthDefenderSpaceship2"
    case .spaceship3:  return "EarthDefenderSpaceShip3"
    case .alien: return "EarthDefenderAlien"
    case .alien2: return "EarthDefenderAlien2"
    case .commetBoss: return "EarthDefenderCommetBoss"
    case .asteroidBoss: return "EarthDefenderAsteroidboss"
    case .spaceshipBoss1: return "EarthDefenderSpaceshipboss1"
    case .spaceshipBoss2: return "EarthDefenderShipboss2"
    case .alienBoss: return "EarthDefenderalienBoss"
    case .spaceshipBoss3: return "spaceShipBoss"
    }
}

func getLives(for monsterType: MonsterType) -> Int {
    switch monsterType {
    case .commet: return 1
    case .asteroid: return 1
    case .spaceship: return 2
    case .spaceship2: return 2
    case .spaceship3: return 3
    case .alien: return 3
    case .alien2: return 3
    case .commetBoss: return 10
    case .asteroidBoss: return 15
    case .spaceshipBoss1: return 18
    case .spaceshipBoss2: return 20
    case .alienBoss: return 24
    case .spaceshipBoss3: return 35
    }
}

func getSpeed(for monsterType: MonsterType) -> Double {
    switch monsterType {
    case .commet: return 7.0
    case .asteroid: return 6.0
    case .spaceship: return 5.0
    case .spaceship2: return 4.0
    case .spaceship3: return 3.0
    case .alien: return 3.5
    case .alien2: return 3.0
    case .commetBoss: return 2.0
    case .asteroidBoss: return 2.0
    case .spaceshipBoss1: return 2.0
    case .spaceshipBoss2: return 2.0
    case .alienBoss: return 2.0
    case .spaceshipBoss3: return 2.0
    }
}














