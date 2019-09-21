//
//  NetworkController.swift
//  
//
//  Created by Михаил Медведев on 26/07/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class NetworkController {
    
    private let jsonDataFetcher: JSONDataFetchable
    private let jsonDataSender: JSONDataSendable
    private let imageFetcher: ImageFetcher
    
    init(
        jsonDataFetcher: JSONDataFetchable = JSONDataFetcher(),
        jsonDataSender: JSONDataSendable = JSONDataSender(),
        imageFetcher: ImageFetcher = ImageFetcher()
        ) {
        self.jsonDataFetcher = jsonDataFetcher
        self.jsonDataSender = jsonDataSender
        self.imageFetcher = imageFetcher
    }
    
    let baseURL = "http:/localhost:8080"
    
     func makeApiURL() -> URL? {
        
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 8080
        components.path = "/api/v1"
        
        return components.url
    }
    
    func fetchQuestions(completion: @escaping ([Question]?) -> Void) {
        guard let baseUrl = makeApiURL() else { return }
        let url = baseUrl.appendingPathComponent("questions")
        print(url)
        jsonDataFetcher.fetchJSONData(url: url, requestType: .get, headers: nil, response: completion)
    }
    
    func fetchAnswers(completion: @escaping ([Answer]?) -> Void) {
        guard let baseUrl = makeApiURL() else { return }
        let url = baseUrl.appendingPathComponent("answers")
        print(url)
        jsonDataFetcher.fetchJSONData(url: url, requestType: .get, headers: nil, response: completion)
    }
    
    func fetchTypes(completion: @escaping ([Type]?) -> Void) {
        guard let baseUrl = makeApiURL() else { return }
        let url = baseUrl.appendingPathComponent("types")
        print(url)
        jsonDataFetcher.fetchJSONData(url: url, requestType: .get, headers: nil, response: completion)
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
            imageFetcher.fetchImage(url: url, response: completion)
    }
    
}
