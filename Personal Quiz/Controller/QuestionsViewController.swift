//
//  QuestionsViewController.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 09/05/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    private var quiz = Question.loadData()
    private var userPoints = 0
    private var currentQuestionIndex = 0
    
    //MARK: - OUTLETS
    
    //main stackViews
    @IBOutlet weak var chooseOnlyOneRightAnswerStackView: UIStackView!
    @IBOutlet weak var tapImageToAnswerStackView: UIStackView!
    @IBOutlet weak var slideToAnswerStackView: UIStackView!
    @IBOutlet weak var selectRightAnswersStackView: UIStackView!
    
    //progress Bar
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    //slider
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var labelOfSlider: UILabel!
    
}

extension QuestionsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNextQuestion()
    }
    
    //MARK: Slider Action
    @IBAction func slideAction(_ sender: UISlider) {
        labelOfSlider.text = "\(Int(sender.value))"
    }
    
    //MARK: - TAP BUTTON TO ANSWER
    @IBAction func userTappedButtonToAnswer(_ sender: UIButton) {
        
        //CALCULATE POINTS
        let currentQuestion = quiz[currentQuestionIndex]
        
        switch currentQuestion.type {
        case .chooseOnlyOneRightAnswer:
            for answer in currentQuestion.answers {
                if answer.text == sender.currentTitle {
                    userPoints += answer.point
                }
            }
            break
            
        case .selectRightAnswers:
            
            //define switchers
            let subStackView = selectRightAnswersStackView.arrangedSubviews[1] as! UIStackView
            
            for index in 0..<subStackView.arrangedSubviews.count {
                
                let subViewObject = subStackView.arrangedSubviews[index] as! UIStackView
                let switchLabel = subViewObject.arrangedSubviews[1] as! UISwitch
                if currentQuestion.answers[index].point == 1 {
                    if switchLabel.isOn {
                        userPoints += 1
                    }
                }
            }
            break
            
        case .slideToAnswer:
            for answer in currentQuestion.answers {
                if labelOfSlider.text == answer.text {
                    userPoints += answer.point
                }
            }
            
        case .tapImageToAnswer: break
            
        }
        
        currentQuestionIndex += 1
        showNextQuestion()
    }
    
    
    //MARK: Setup Labels and Answers
    private func showNextQuestion() {
        
        guard currentQuestionIndex < quiz.count else {
            
            //MARK: Perform Segue in the end of quiz
            performSegue(withIdentifier: "ResultsSegue", sender: self)
            
            return
        }
        
        let stackViews = [chooseOnlyOneRightAnswerStackView, tapImageToAnswerStackView, slideToAnswerStackView,selectRightAnswersStackView]
        let currentQuestion = quiz[currentQuestionIndex]
        
        switch currentQuestion.type {
            
        case .chooseOnlyOneRightAnswer:
            //MARK: setup view in chooseOnlyOneRightAnswerStackView
            let questionLabel = chooseOnlyOneRightAnswerStackView.arrangedSubviews[0] as! UILabel
            questionLabel.text = currentQuestion.text
            
            //Define buttons in StackView
            let subStackView = chooseOnlyOneRightAnswerStackView.arrangedSubviews[1] as! UIStackView
            let subStackViewItems = subStackView.arrangedSubviews
            
            //Set titles for answers
            for itemIndex in 0..<subStackViewItems.count {
                let button = subStackViewItems[itemIndex] as! UIButton
                button.setTitle(currentQuestion.answers[itemIndex].text, for: .normal)
            }
            
            hideStackViews(in: stackViews, except: chooseOnlyOneRightAnswerStackView)
            navigationItem.title = "Выберите один из вариантов:"
            
            break
            
        case .selectRightAnswers:
            
            //MARK: setup view in selectRightAnswersStackView
            let questionLabel = selectRightAnswersStackView.arrangedSubviews[0] as! UILabel
            
            questionLabel.text = currentQuestion.text
            
            //define labels and switchers
            let subStackView = selectRightAnswersStackView.arrangedSubviews[1] as! UIStackView
            
            for index in 0..<subStackView.arrangedSubviews.count {
                
                let subViewObject = subStackView.arrangedSubviews[index] as! UIStackView
                
                //setup answers to labels
                let label = subViewObject.arrangedSubviews[0] as! UILabel
                label.text = currentQuestion.answers[index].text
                
                //setup switchers
                let switchLabel = subViewObject.arrangedSubviews[1] as! UISwitch
                switchLabel.isOn = false
                
                
            }
            
            hideStackViews(in: stackViews, except: selectRightAnswersStackView)
            navigationItem.title = "Отметьте верные варианты:"
            
            break
            
        case .slideToAnswer:
            //MARK: setup view in slideToAnswerStackView
            let questionLabel = slideToAnswerStackView.arrangedSubviews[0] as! UILabel
            questionLabel.text = currentQuestion.text
            
            //setup slider
            slider.minimumValue = 1
            slider.maximumValue = 10
            
            slider.value = Float.random(in: 1...10)
            labelOfSlider.text = "\(Int(slider.value))"
            
            hideStackViews(in: stackViews, except: slideToAnswerStackView)
            navigationItem.title = "Передвигайте ползунок:"
            break
            
        case .tapImageToAnswer:
            //MARK: setup view in tapImageToAnswerStackView
            let questionLabel = tapImageToAnswerStackView.arrangedSubviews[0] as! UILabel
            questionLabel.text = currentQuestion.text
            
            let imageStackView = tapImageToAnswerStackView.arrangedSubviews[1] as! UIStackView
            for index in 0..<imageStackView.arrangedSubviews.count {
                
                //setup images to ImageViews
                let imageView = imageStackView.arrangedSubviews[index] as! UIImageView
                
                imageView.image = UIImage(named: currentQuestion.answers[index].text)
                
                // create tap gesture recognizer
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gesture:)))
                imageView.addGestureRecognizer(tapGesture)
            }
            
            hideStackViews(in: stackViews, except: tapImageToAnswerStackView)
            navigationItem.title = "Нажмите на изображение"
            break
        }
        
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
    
    //MARK: Image Tapping calculations
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        
        guard let image = gesture.view as? UIImageView else { return }
        
        //animate tap on image
        image.alpha = 0.5
        UIView.animate(withDuration: 0.5) {
            image.alpha = 1.0
            
        }
        
        //Calculate UserPoints
        let currentQuestion = quiz[currentQuestionIndex]
        
        if currentQuestionIndex < quiz.count {
            for answer in currentQuestion.answers {
                if image.image == UIImage(named: answer.text) && answer.point == 1 {
                    userPoints += answer.point
                    
                }
            }
            
            currentQuestionIndex += 1
            showNextQuestion()
            
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let resultsVC = segue.destination as? ResultsViewController {
            resultsVC.result = interpretateResults(in: quiz, with: userPoints)
        }
        
    }
    
}
