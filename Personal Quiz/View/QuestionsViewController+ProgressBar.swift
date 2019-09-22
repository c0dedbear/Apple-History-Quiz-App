//
//  QuestionsViewController+ProgressBar.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 22/09/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import Foundation

extension QuestionsViewController {
func setupProgressBar() {
    //MARK: Progress Bar Settings
    let progressPoint = Float(1.0) / Float(quiz.count)
    
    if progressBar.progress == 0 {
        progressLabel.text = "Вопрос \(currentQuestionIndex + 1) из \(quiz.count)"
        progressBar.progress = progressPoint
    } else {
        progressBar.setProgress(progressBar.progress + progressPoint, animated: true)
        progressLabel.text = "Вопрос \(currentQuestionIndex + 1) из \(quiz.count)"
    }
}
}
