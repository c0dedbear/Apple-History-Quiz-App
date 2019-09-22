//
//  showCurrentStackView.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 22/09/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import UIKit

extension QuestionsViewController {
    /// Controls Stack Views appearence
    ///
    /// - Parameter sender: UIButton
    func showCurrentStackView(sender: UIButton) {
        let currentQuestion = quiz[currentQuestionIndex]
        guard let currentQuestionType = currentQuestion.type else { return }
        
        switch currentQuestionType.name {
        case "chooseOnlyOneRightAnswer":
            for answer in currentQuestion.answers! {
                if answer.text == sender.currentTitle {
                    userPoints += answer.point
                }
            }
        case "selectRightAnswers":
            
            ///define switchers
            let subStackView = selectRightAnswersStackView.arrangedSubviews[1] as! UIStackView
            
            for index in 0..<subStackView.arrangedSubviews.count {
                
                let subViewObject = subStackView.arrangedSubviews[index] as! UIStackView
                let switchLabel = subViewObject.arrangedSubviews[1] as! UISwitch
                if currentQuestion.answers![index].point == 1 {
                    if switchLabel.isOn {
                        userPoints += 1
                    }
                }
            }
        case "slideToAnswer":
            for answer in currentQuestion.answers! {
                if labelOfSlider.text == answer.text {
                    userPoints += answer.point
                }
            }
            
        case "tapImageToAnswer": break
        default: break
            
        }
        
        currentQuestionIndex += 1
        showNextQuestion()
    }
}
