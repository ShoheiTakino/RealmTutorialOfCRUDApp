//
//  GenerateUUIDService.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/25.
//

import Foundation

struct GenerateUUIDService {
    
    static func getUUID() -> String {
        return UUID().uuidString
    }
}
