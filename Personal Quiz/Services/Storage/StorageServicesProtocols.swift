//
//  StorageServicesProtocols.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 20/09/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import UIKit

protocol StorageManagable {
    func save<T: Codable>(data: T)
    func load<T: Codable>(model: T.Type) -> T?
}



