//
//  QuestionsViewController.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 09/05/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    //MARK: Stored Properties
    private var quiz = [Question]()
    private var currentQuestionIndex = 0
    private var userPoints = 0
    //Dependencies
    private let networkController = NetworkController()
    private let storageController = StorageController()
    
    //MARK: Outlets
    //main stackViews
    @IBOutlet weak var chooseOnlyOneRightAnswerStackView: UIStackView!
    @IBOutlet weak var tapImageToAnswerStackView: UIStackView!
    @IBOutlet weak var slideToAnswerStackView: UIStackView!
    @IBOutlet weak var selectRightAnswersStackView: UIStackView!
    
    //progress Bar
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    //slider
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var labelOfSlider: UILabel!
    
    //MARK: VC Life cycyle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        getQuiz()
    }
    
    
    //MARK: IBAction methods
    
    /// Controls slider
    ///
    /// - Parameter sender: UISlider
    @IBAction func slideAction(_ sender: UISlider) {
        labelOfSlider.text = "\(Int(sender.value))"
    }
    
    /// Tap button to answer action
    ///
    /// - Parameter sender: UIButton
    @IBAction func userTappedButtonToAnswer(_ sender: UIButton) {
        showCurrentStackView(sender: sender)
    }
    
}

// MARK: - Setup View
extension QuestionsViewController {
    
    private func showNextQuestion() {
        self.activityIndicatorView.stopAnimating()
        //End of the Quiz
        guard currentQuestionIndex < quiz.count else {
            //Perform Segue in the end of quiz
            performSegue(withIdentifier: "ResultsSegue", sender: self)
            return
        }
        
        //define stacksview
        let stackViews = [chooseOnlyOneRightAnswerStackView, tapImageToAnswerStackView, slideToAnswerStackView,selectRightAnswersStackView]
        
        //define current question
        let currentQuestion = quiz[currentQuestionIndex]
        print(currentQuestion)
        
        guard let currentQuestionType = currentQuestion.type else { return }
        
        //Set Views
        switch currentQuestionType.name {
        case "chooseOnlyOneRightAnswer":
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
            
        case "selectRightAnswers":
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
            
        case "slideToAnswer":
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
            
        case "tapImageToAnswer":
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
                        self.activityIndicatorView.startAnimating()
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
            
        default: break
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

//MARK: - Image Tapping calculations
extension QuestionsViewController {
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        
        guard let imageView = gesture.view as? UIImageView else { return }
        //animate tap on image
        imageView.alpha = 0.5
        UIView.animate(withDuration: 0.5) {
            imageView.alpha = 1.0
            
        }
        
        //Calculate UserPoints
        let currentQuestion = quiz[currentQuestionIndex]
        print(imageView.tag)
        if currentQuestionIndex < quiz.count {
            for answer in currentQuestion.answers! {
                if imageView.image?.accessibilityIdentifier == "1" && answer.point == 1 {
                    print("right image")
                    userPoints += answer.point
                }
            }
            currentQuestionIndex += 1
            showNextQuestion()
        }
    }
}

// MARK: - InterpretateResults
extension QuestionsViewController {
    func defineMaxPossiblePoints(in quiz: [Question]) -> Int {
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

//MARK: - Fetch Quiz Data From Network
extension QuestionsViewController {
    func getQuiz() {
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
    
    func loadQuizFromStorage() {
        guard let offlineQuiz = storageController.loadQuestions() else {
            self.activityIndicatorView.startAnimating()
            return
        }
        quiz = offlineQuiz
        print("Load cached Quiz")
        showNextQuestion()
    }
}

// MARK: - Navigation
extension QuestionsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultsVC = segue.destination as? ResultsViewController {
            resultsVC.userPoints = (userPoints, defineMaxPossiblePoints(in: quiz))
        }
    }
}
