//
//  BackgroundType.swift
//  EarthDefender
//
//  Created by Kids on 2017-06-11.
//  Copyright © 2017 Sam. All rights reserved.
//

import Foundation
import CoreGraphics

enum BackgroundType: Int {
    case earth
    case mars
    case pluto
}

func fileName(for backgroundType: BackgroundType) -> String {
    switch backgroundType {
    case .earth: return "StartLevel"
    case .mars: return "Level2"
    case .pluto: return "Level3"
    }
}

//func xSize(for backgroundType: BackgroundType) -> CGFloat {
//    switch backgroundType {
//    case .earth: return 0.9
//    case .mars: return 2.5
//    case .pluto: return 1.5
//    }
//}
//
//func ySize(for backgroundType: BackgroundType) -> CGFloat {
//    switch backgroundType {
//    case .earth: return 1.3
//    case .mars: return 1.9
//    case .pluto: return 1.3
//    }
//}
//
