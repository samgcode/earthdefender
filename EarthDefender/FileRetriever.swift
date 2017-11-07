//
//  FileRetriever.swift
//  EarthDefender
//
//  Created by Dean on 2017-11-06.
//  Copyright © 2017 Sam. All rights reserved.
//

import Foundation

class FileNameRetriever {
    static func imageFileName(fileName: String) -> String {
        var fileNameForDevice = fileName
        if(Constants.IS_IPHONE_X){
            fileNameForDevice = fileNameForDevice + "-X"
        }
        return fileNameForDevice
    }
}
