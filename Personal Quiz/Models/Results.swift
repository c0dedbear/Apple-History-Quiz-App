//
//  Result.swift
//  Application
//
//  Created by Михаил Медведев on 20/09/2019.
//

import Foundation

struct Result: Codable {
    var character: String
    var description: String
}

struct UserPoints: Codable {
    var gained: Int
    var maxPossiblePoints: Int
}

