//
//  Question.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 09/05/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//


struct Question: Codable, Hashable {
    var id: Int?
    var typeId: Int
    var text: String
    var answers: [Answer]?
    var type: Type?
    
    static func defineMaxPossiblePoints(in quiz: [Question]) -> Int {
        var points = 0
        for question in quiz {
            for answer in question.answers! {
                if answer.point != 0 {
                    points += answer.point
                }
            }
        }
        return points
    }
}

