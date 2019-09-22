//
//  fetchQuiz.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 22/09/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import Foundation
//MARK: - Fetch Quiz
extension QuestionsViewController {
    func fetchQuiz() {
        var questionsWithTypes = [Question]()
        //fetch questions
        networkController.fetchQuestions { serverQuestions in
            guard let fetchedQuestions = serverQuestions else {
                self.loadQuizFromStorage()
                return
            }
            //fetch types
            self.networkController.fetchTypes { serverTypes in
                guard let fetchedTypes = serverTypes else {
                    self.loadQuizFromStorage()
                    return
                }
                //compare id's and add types to questions
                for var question in fetchedQuestions {
                    fetchedTypes.forEach(){ type in
                        if question.typeId == type.id {
                            question.type = type
                            questionsWithTypes.append(question)
                        }
                    }
                }
                //fetch answers
                self.networkController.fetchAnswers { serverAnswers in
                    guard let fetchedAnswers = serverAnswers else {
                        self.loadQuizFromStorage()
                        return
                    }
                    for var question in questionsWithTypes {
                        fetchedAnswers.forEach(){ answer in
                            if answer.questionId == question.id  {
                                question.answers = fetchedAnswers.filter(){ $0.questionId == question.id }
                                self.quiz.append(question)
                            }
                        }
                    }
                    //remove duplicates from Quiz
                    self.quiz.removeDuplicates()
                    //shuffled
                    self.quiz.shuffle()
                    //store Quiz
                    self.storageController.saveQuestions(data: self.quiz)
                    //start Quiz
                    self.showNextQuestion()
                }
            }
        }
    }
}
