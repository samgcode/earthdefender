//
//  ScenePhysicsCategory.swift
//  EarthDefender
//
//  Created by Kids on 2017-04-16.
//  Copyright © 2017 Sam. All rights reserved.
//

import Foundation

struct ScenePhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Monster   : UInt32 = 0b1       // 1
    static let Projectile: UInt32 = 0b10      // 2
}
