//
//  NetworkController.swift
//  
//
//  Created by Михаил Медведев on 26/07/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import Foundation

class NetworkController {
    
    private let jsonDataFetcher: JSONDataFetchable
    private let jsonDataSender: JSONDataSendable
    
    init(jsonDataFetcher: JSONDataFetchable = JSONDataFetcher(), jsonDataSender: JSONDataSendable = JSONDataSender()) {
        self.jsonDataFetcher = jsonDataFetcher
        self.jsonDataSender = jsonDataSender
    }
    
//    private func makeURL() -> URL? {
//        var parameters = [String:String]()
//        parameters["page"] = String(page)
//        parameters["per_page"] = "12"
//        parameters["order_by"] = "latest"
//
//        var components = URLComponents()
//        components.scheme = "http"
//        components.host = "localhost"
//        components.port = 8080
//        components.path = "/photos"
//        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
//
//        return components.url
//
//    }
    
//    private func makeHeaders() -> [String:String]? {
//        var headers = [String:String]()
//        headers["Authorization"] = "Client-ID d199ddd69d12752f8d8695e8685aab6ae3fb965e60a9697f70056b17bb7625e9"
//        return headers
//    }
    
//    func fetchPicturesInfo(page: Int,completion: @escaping ([Picture]?) -> Void) {
//        guard let url = makeURL(with: page) else { return }
//        jsonDataFetcher.fetchJSONData(url: url, requestType: .get, headers: makeHeaders(), response: completion)
//    }
    
}
