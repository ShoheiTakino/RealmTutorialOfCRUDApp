//
//  TodoModel.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/24.
//

import Foundation
import RealmSwift

final class TodoModel: Object {
    @objc dynamic var title: String?
    @objc dynamic var regDate: Date?
}
