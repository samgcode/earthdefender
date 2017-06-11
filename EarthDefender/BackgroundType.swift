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
}

func fileName(for backgroundType: BackgroundType) -> String {
    switch backgroundType {
    case .earth: return "earthDefenderbackground"
    case .mars: return "EarthDefenderBackground2"
    }
}

func xSize(for backgroundType: BackgroundType) -> CGFloat {
    switch backgroundType {
    case .earth: return 0.9
    case .mars: return 2.5
    }
}

func ySize(for backgroundType: BackgroundType) -> CGFloat {
    switch backgroundType {
    case .earth: return 1.3
    case .mars: return 1.8
    }
}

