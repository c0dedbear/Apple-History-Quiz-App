//
//  ConfigureStackViews.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 22/09/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import UIKit

//MARK: Configure View
extension QuestionsViewController {
    
     func configureChooseOnlyOneRightAnswerStackView(stackViews: [UIStackView?], currentQuestion: Question, currentQuestionType: Type) {
        //setup view in chooseOnlyOneRightAnswerStackView
        let questionLabel = chooseOnlyOneRightAnswerStackView.arrangedSubviews[0] as! UILabel
        questionLabel.text = currentQuestion.text
        
        //Define buttons in StackView
        let subStackView = chooseOnlyOneRightAnswerStackView.arrangedSubviews[1] as! UIStackView
        let subStackViewItems = subStackView.arrangedSubviews
        
        //Set titles for answers
        for itemIndex in 0..<subStackViewItems.count {
            let button = subStackViewItems[itemIndex] as! UIButton
            button.setTitle(currentQuestion.answers![itemIndex].text, for: .normal)
        }
        
        hideStackViews(in: stackViews, except: chooseOnlyOneRightAnswerStackView)
        navigationItem.title = currentQuestionType.description
    }
    
    func configureSelectRightAnswersStackView(stackViews: [UIStackView?], currentQuestion: Question, currentQuestionType: Type) {
        //setup view in selectRightAnswersStackView
        let questionLabel = selectRightAnswersStackView.arrangedSubviews[0] as! UILabel
        questionLabel.text = currentQuestion.text
        
        //define labels and switchers
        let subStackView = selectRightAnswersStackView.arrangedSubviews[1] as! UIStackView
        
        for index in 0..<subStackView.arrangedSubviews.count {
            let subViewObject = subStackView.arrangedSubviews[index] as! UIStackView
            //setup answers to labels
            let label = subViewObject.arrangedSubviews[0] as! UILabel
            label.text = currentQuestion.answers![index].text
            //setup switchers
            let switchLabel = subViewObject.arrangedSubviews[1] as! UISwitch
            switchLabel.isOn = false
        }
        
        hideStackViews(in: stackViews, except: selectRightAnswersStackView)
        navigationItem.title = currentQuestionType.description
        
    }
    
    func configureSlideToAnswerStackView(stackViews: [UIStackView?], currentQuestion: Question, currentQuestionType: Type) {
        //setup view in slideToAnswerStackView
        let questionLabel = slideToAnswerStackView.arrangedSubviews[0] as! UILabel
        questionLabel.text = currentQuestion.text
        //setup slider
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.value = Float.random(in: 1...10)
        labelOfSlider.text = "\(Int(slider.value))"
        
        hideStackViews(in: stackViews, except: slideToAnswerStackView)
        navigationItem.title = currentQuestionType.description
    }
    
    func configureTapImageToAnswerStackView(stackViews: [UIStackView?], currentQuestion: Question, currentQuestionType: Type) {
        //setup view in tapImageToAnswerStackView
        let questionLabel = tapImageToAnswerStackView.arrangedSubviews[0] as! UILabel
        questionLabel.text = currentQuestion.text
        
        let imageStackView = tapImageToAnswerStackView.arrangedSubviews[1] as! UIStackView
        for index in 0..<imageStackView.arrangedSubviews.count {
            
            //setup images to ImageViews
            let imageView = imageStackView.arrangedSubviews[index] as! UIImageView
            
            //MARK: Fetch images
            guard
                let url = currentQuestion.answers?[index].text,
                let imageUrl = URL(string: networkController.baseURL + url)
                else { return }
            
            networkController.fetchImage(url: imageUrl) { serverImage in
                guard let fetchedImage = serverImage else {
                    print("No image fetched ⁉️")
                    return
                }
                
                if currentQuestion.answers![index].point == 1  {
                    fetchedImage.accessibilityIdentifier = "1"
                }
                
                //update imageView
                DispatchQueue.main.async {
                    imageView.image = fetchedImage
                }
            }
            // create tap gesture recognizer
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gesture:)))
            imageView.addGestureRecognizer(tapGesture)
        }
        
        hideStackViews(in: stackViews, except: tapImageToAnswerStackView)
        navigationItem.title = currentQuestionType.description
    }
}
