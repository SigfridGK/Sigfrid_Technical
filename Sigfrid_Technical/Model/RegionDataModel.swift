//
//  RegionDataModel.swift
//  Sigfrid_Technical
//
//  Created by Sigfrid Acabal on 8/15/23.
//

import Foundation

struct RegionDataModel: Codable {
    var region: String
    var capital: [String] = []
    var name: RegionName
}

struct RegionName: Codable {
    var common: String
    var official: String
}
