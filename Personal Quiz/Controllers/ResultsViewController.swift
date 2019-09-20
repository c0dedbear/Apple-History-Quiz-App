//
//  ResultsViewController.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 09/05/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var userPoints = (gained: 0, maxPossiblePoints: 0)
    var result = [Character : String]()
    
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userPointsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup view
        navigationItem.hidesBackButton = true
        userPointsLabel.text = " Вы набрали \(userPoints.gained) очков из \(userPoints.maxPossiblePoints)."
        for (char, description) in result {
            characterLabel.text = "\(char)"
            descriptionLabel.text = description
        }
    }
    
    //TODO: Make network request for interpretate quiz results

}
