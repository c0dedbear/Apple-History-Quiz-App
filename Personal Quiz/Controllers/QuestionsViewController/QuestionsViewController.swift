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
    var quiz = [Question]()
    var currentQuestionIndex = 0
    var userPoints = 0
    
    var offlineMode = false {
        didSet {
            navigationController?.overrideUserInterfaceStyle = offlineMode ? .dark : .light
            let offlineLabel = UILabel()
            offlineLabel.text = "Режим оффлайн"
            offlineLabel.font = .systemFont(ofSize: 9)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: offlineLabel)
        }
    }
    
    //Dependencies
    let networkController = NetworkController()
    let storageController = StorageController()
    
    //MARK: @IBOutlets
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
        navigationController?.navigationBar.isHidden = false
        fetchQuiz()
    }
    
    
    //MARK: @IBAction methods
    
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

// MARK: - Next Question
extension QuestionsViewController {
    
    func showNextQuestion() {
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
        
        guard let currentQuestionType = currentQuestion.type else { return }
        
        //Manage Stack Views
        switch currentQuestionType.name {
        case "chooseOnlyOneRightAnswer":
            configureChooseOnlyOneRightAnswerStackView(stackViews: stackViews, currentQuestion: currentQuestion, currentQuestionType: currentQuestionType)
        case "selectRightAnswers":
            configureSelectRightAnswersStackView(stackViews: stackViews, currentQuestion: currentQuestion, currentQuestionType: currentQuestionType)
        case "slideToAnswer":
            configureSlideToAnswerStackView(stackViews: stackViews, currentQuestion: currentQuestion, currentQuestionType: currentQuestionType)
        case "tapImageToAnswer":
            configureTapImageToAnswerStackView(stackViews: stackViews, currentQuestion: currentQuestion, currentQuestionType: currentQuestionType)
        default: break
        }
        
        setupProgressBar()
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
        
        if currentQuestionIndex < quiz.count {
            for answer in currentQuestion.answers! {
                if imageView.image?.accessibilityIdentifier == "1" && answer.point == 1 {
                    userPoints += answer.point
                }
            }
            currentQuestionIndex += 1
            showNextQuestion()
        }
    }
}


// MARK: - Navigation
extension QuestionsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultsVC = segue.destination as? ResultsViewController {
            resultsVC.userPoints = (userPoints, Question.defineMaxPossiblePoints(in: quiz))
        }
    }
}
