//
//  Question.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 09/05/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//


struct Question: Codable {
    var text: String
    var answers: [Answer]
    var type: Type
}

extension Question: Hashable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.text == rhs.text && lhs.type == rhs.type
    }
}
