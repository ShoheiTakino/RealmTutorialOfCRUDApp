//
//  RealmDBConverter.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/25.
//

import Foundation
import RealmSwift

struct RealmDBConverter {
    
    static func convertToModelFrom<T>(object: Results<T>) -> [T] {
        var list: [T] = []
        for i in 0..<object.count {
            list.insert(object[i], at: 0)
        }
        return list
    }
}
