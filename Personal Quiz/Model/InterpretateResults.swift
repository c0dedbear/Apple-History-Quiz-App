//
//  InterpretateResults.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 11/05/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import Foundation

func interpretateResults(in quiz: [Question], with points: Int) -> [Character:String] {
    
    switch  points {
    case 0:
        return ["👽": "Вы совсем ничего не знаете об Apple. Вероятно вы из другой галактики."]
    case 1...3:
        return ["👂🏻": "Вы краем уха что-то слышали об этой компании, хотя возможно это были какие то другие яблоки."]
    case 4...7:
        return ["🙌🏻": "Вероятно, что вы знаете об Apple не по наслышке и в силах отличить Стива Джобса от Билла Гейтса"]
    case 8...11:
        return ["👍🏻": "Вы неплохо знаете историю компании, но явно что то забыли. Может попробуете еще раз?"]
    case 12...14:
        return ["♥️": "Вы ответили правильно на большинство вопросов. Вы явно любите Apple и неплохо знаете ее историю!"]
    case 15:
        return ["🕶": "Вы ответили верно абсолютно на все вопросы! Джонни Айв ты ли это?"]
    default:
        break
    }
    
    return ["🤖":"Error!"]
}
