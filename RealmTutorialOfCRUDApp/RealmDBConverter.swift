//
//  RealmDBConverter.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/25.
//

import Foundation
import RealmSwift

struct RealmDBConverter {
    
    /// Results型で取得することになっているデータを任意の型に形成する処理
    /// - Parameter object: RealmのResults型で返却される値
    /// - Returns: RealmのResults型から形成されたされた任意の型の配列
    static func convertToModelFrom<T>(object: Results<T>) -> [T] {
        Array(object.reversed())
    }
}
