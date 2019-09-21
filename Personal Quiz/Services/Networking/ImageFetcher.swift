//
//  ImageFetcher.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 20/09/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import UIKit

class ImageFetcher {
    
    let imageCache = NSCache<NSString, UIImage>()
    
    private let networkService: NetworkRequestable
    private let storageService: StorageService
    
    // can be initializated with other classes in future (depending of request types)
    init(networkService: NetworkRequestable = NetworkService(),
         storageServive: StorageService = StorageService()
        ) {
        self.networkService = networkService
        self.storageService = storageServive
    }
    
    /// Fetching Image
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - response: (UIImage?) -> Void
    func fetchImage(url: URL, response: @escaping (UIImage?) -> Void) {
        networkService.request(to: url, type: .get, headers: nil, with: nil) { data, error in
            guard let data = data else {
                response(nil)
                return
            }
            guard let image = UIImage(data: data) else {
                print("Fetched data is not Image!")
                response(nil)
                return
            }
            response(image)
        }
    }
    
}

