//
//  StorageController.swift
//  UnsplashPictures
//
//  Created by Михаил Медведев on 30/08/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit

class StorageController {
    
    private let storageService: StorageManagable
    init(storageService: StorageManagable = StorageService()) {
        self.storageService = storageService
    }

    func saveQuestions(data: [Question]) {
        storageService.save(data: data)
    }
    
    func loadQuestions() -> [Question]? {
        return storageService.load(model: [Question].self)
    }

}
