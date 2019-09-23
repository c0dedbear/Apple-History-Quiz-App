//
//  ResultsViewController.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 09/05/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    //MARK: - Properties
    let networkController = NetworkController()
    
    var userPoints = UserPoints(gained: 0, maxPossiblePoints: 0)
    var result = Result(character: "", description: "")
    
    //MARK: - @IBOutlets
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userPointsLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    //MARK: - VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshButton.isHidden = true
        navigationItem.hidesBackButton = true
        getResults()
    }
    
    //MARK: - @IBActions
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        getResults()
    }
    
    //MARK: - Methods
    fileprivate func setupView(offline: Bool) {
        //setup view
        userPointsLabel.text = "Вы набрали \(userPoints.gained) очков из \(userPoints.maxPossiblePoints)."
        
        refreshButton.isHidden = !offline
        characterLabel.text = offline ? "😵" : result.character
        descriptionLabel.text = offline ? "Не удалось получить результат. Это могло возникнуть из-за отсутствия сети или сбоя в работе удаленного сервера" : result.description
        
    }
    
    //MARK: - Make network request for interpretate quiz results
    private func getResults() {
        networkController.fetchResults(points: userPoints) { serverResult, error  in
            if let error = error {
                print(error)
            }
            guard let fetchedResult = serverResult as? [String:String] else {
                self.overrideUserInterfaceStyle = .dark
                DispatchQueue.main.async {
                    self.setupView(offline: true)
                }
                
                return
            }
            let encoder = JSONEncoder(); let decoder = JSONDecoder()
            guard let data = try? encoder.encode(fetchedResult) else { return }
            
            guard let result = try? decoder.decode(Result.self, from: data) else { return }
            self.result = result
            
            DispatchQueue.main.async {
                self.setupView(offline: false)
            }
        }
    }
}
