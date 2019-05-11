//
//  Question.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 09/05/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//


struct Question {
    
    var text: String
    var answers: [Answer]
    var type: ResponseType
    
    static func loadData() -> [Question] {
        return [
                Question(text: "В каком году была основана компания Apple?",
                         answers: [Answer(text: "1976", point: 1),
                                   Answer(text: "2011", point: 0),
                                   Answer(text: "1984", point: 0),
                                   Answer(text: "1964", point: 0)].shuffled(),
                         type: .chooseOnlyOneRightAnswer),

                Question(text: "В какой компании успел поработать Стив Джобс когда ему было 12 лет?",
                         answers: [Answer(text: "IBM", point: 0),
                                   Answer(text: "Motorola", point: 0),
                                   Answer(text: "Microsoft", point: 0),
                                   Answer(text: "HP", point: 1)].shuffled(),
                         type: .chooseOnlyOneRightAnswer),

                Question(text: "Какая компания выпустила для Apple первый телефон c iTunes?",
                         answers: [Answer(text: "Samsung", point: 0),
                                   Answer(text: "Motorola", point: 1),
                                   Answer(text: "Sony", point: 0),
                                   Answer(text: "Nokia", point: 0)].shuffled(),
                         type: .chooseOnlyOneRightAnswer),

                Question(text: "Кто является основателем Apple Computer?",
                         answers: [Answer(text: "Стив Джобс", point: 1),
                                   Answer(text: "Рональд Уэйн", point: 1),
                                   Answer(text: "Стив Возняк", point: 1),
                                   Answer(text: "Тим Кук", point: 0)].shuffled(),
                         type: .selectRightAnswers),

                Question(text: "Какими компаниями руководил Джобс будучи уволенным из Apple?",
                         answers: [Answer(text: "NeXT", point: 1),
                                   Answer(text: "Pixar", point: 1),
                                   Answer(text: "Pepsi", point: 0),
                                   Answer(text: "Disney", point: 0)].shuffled(),
                         type: .selectRightAnswers),

                Question(text: "Какие из этих продуктов Apple когда-либо выпускала на рынок?",
                         answers: [Answer(text: "Игровая приставка", point: 1),
                                   Answer(text: "Bluetooth-гарнитура", point: 1),
                                   Answer(text: "Телевизор-компьютер", point: 1),
                                   Answer(text: "Холодильник", point: 0)].shuffled(),
                         type: .selectRightAnswers),

                Question(text: "Как выглядел первый логотип компании Apple?",
                         answers: [Answer(text: "first logo", point: 1),
                                   Answer(text: "second logo", point: 0),
                                   Answer(text: "third logo", point: 0)].shuffled(),
                         type: .tapImageToAnswer),

                Question(text: "На каком фото изображен компьютер Apple 1?",
                         answers: [Answer(text: "Apple 1", point: 1),
                                   Answer(text: "Apple LIsa", point: 0),
                                   Answer(text: "Apple Macintosh", point: 0)].shuffled(),
                         type: .tapImageToAnswer),

                Question(text: "Сколько килограмм весил первый ноутбук от Apple?",
                         answers: [Answer(text: "7", point: 1)], type: .slideToAnswer),

                Question(text: "Сколько мегабайт оперативной памяти было в первом ноутбуке от Apple?",
                         answers: [Answer(text: "1", point: 1)], type: .slideToAnswer)
            ].shuffled()
    }

}
