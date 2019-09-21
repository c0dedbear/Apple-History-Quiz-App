//
//  ResponseTypes.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 09/05/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//


struct Type: Codable, Hashable {
    var id: Int
    var name: String
    var description: String
}
