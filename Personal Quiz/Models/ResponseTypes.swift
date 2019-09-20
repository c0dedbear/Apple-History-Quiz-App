//
//  ResponseTypes.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 09/05/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

enum Type: String, Codable {
    case chooseOnlyOneRightAnswer = "Выберите правильный ответ"
    case selectRightAnswers = "Отметьте верные утверждения"
    case tapImageToAnswer = "Нажмите на картинку"
    case slideToAnswer = "Двигайте ползунок"
}
