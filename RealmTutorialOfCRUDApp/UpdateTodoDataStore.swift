//
//  UpdateTodoDataStore.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/25.
//

import Foundation
import RealmSwift


// MARK: - Input

protocol UpdateTodoDataStoreInput: AnyObject {
    func updateTodoRequest(inputText: String, completion: @escaping(Result<Void, Error>) -> Void)
}

final class UpdateTodoDataStore: UpdateTodoDataStoreInput {
    
    func updateTodoRequest(inputText: String, completion: @escaping(Result<Void, Error>) -> Void) {
        let currentTime = Date()
        let realmDb = try! Realm()

        let todoModel = realmDb.objects(TodoModel.self).first!
        try! realmDb.write{
            todoModel.title = inputText
            todoModel.regDate = currentTime
            completion(.success(()))
        }
    }
}
