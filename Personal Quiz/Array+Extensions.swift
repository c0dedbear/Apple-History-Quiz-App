//
//  Array+Extensions.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 21/09/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//  Got from https://hackingwithswift.com

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
