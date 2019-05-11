//
//  ResultsViewController.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 09/05/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var result = [Character : String]()
    
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        for (char, description) in result {
            
            characterLabel.text = "\(char)"
            descriptionLabel.text = description
        }
    }

}
