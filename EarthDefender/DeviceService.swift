//
//  DeviceService.swift
//  EarthDefender
//
//  Created by Dean on 2018-03-03.
//  Copyright © 2018 Sam. All rights reserved.
//

import Foundation

class DeviceService {
    static func applicationVersion() -> String {
        return Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    }
    
    static func applicationName() -> String {
        return Bundle.main.infoDictionary!["CFBundleName"] as! String
    }
}
