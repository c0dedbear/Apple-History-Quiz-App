//
//  AdminViewController.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 22/09/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController {
    
    let networkController = NetworkController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func uploadButton(_ sender: UIButton) {
        guard let url = URL(string: networkController.baseURL + "/public/images") else {
            print(#line, #function, "invalid url")
            return
        }
        networkController.uploadImage(url: url) { response, error in
            if let error = error {
                print(error)
            }
            guard let response = response else { return }
            print(response)
        }
    }
    
}
