//
//  StorageService.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 20/09/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import UIKit

class StorageService: StorageManagable {
    
    var imageCache: NSCache<NSString, UIImage>
    
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private let dataArchiveURL: URL
    
    init() {
        dataArchiveURL = documentDirectory.appendingPathComponent("Data").appendingPathExtension("plist")
        imageCache = NSCache<NSString, UIImage>()
    }
    
    func save<T:Codable>(data: T) {
        let encoder = PropertyListEncoder()
        guard let encodedData = try? encoder.encode(data) else { return }
        try? encodedData.write(to: dataArchiveURL, options: .noFileProtection)
    }
    
    func load<T:Codable>(model: T.Type) -> T? {
        guard let data = try? Data(contentsOf: dataArchiveURL) else { return nil }
        let decoder = PropertyListDecoder()
        return try? decoder.decode(T.self, from: data)
    }
    
    func cacheImage(image: UIImage, url: URL) {
        imageCache.setObject(image, forKey: url.absoluteString as NSString)
    }
    
    func getImageFromCache(with url: URL) -> UIImage? {
        guard let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) else { return nil }
        return imageFromCache
    }
    
}
