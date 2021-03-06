//
//  LaunchModel.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 16.06.2022.
//

import Foundation

struct Result: Codable, Hashable {
    
    let uuid = UUID()
    let links: Links
    let rocket: String?
    let success: Bool?
    let details: String?
    let name, dateUTC: String?
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case links, rocket, success, details, name
        case dateUTC = "date_utc"
    }
    
    static func == (lhs: Result, rhs: Result) -> Bool {
        lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

struct Links: Codable {
    
    let patch: Patch
    let webcast: String?
    let article: String?
}

struct Patch: Codable {
    let large: String?
}
