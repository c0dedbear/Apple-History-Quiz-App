//
//  loadQuizFromStorage.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 22/09/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import Foundation

extension QuestionsViewController {
    func loadQuizFromStorage() {
        offlineMode = true
        guard let offlineQuiz = storageController.loadQuestions() else {
            self.activityIndicatorView.startAnimating()
            self.navigationItem.title = "Ошибка загрузки данных"
            return
        }
        quiz = offlineQuiz
        showNextQuestion()
    }
}
