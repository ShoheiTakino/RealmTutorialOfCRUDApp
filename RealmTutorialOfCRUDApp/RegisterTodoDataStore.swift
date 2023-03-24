//
//  RegisterTodoDataStore.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/24.
//

import Foundation
import RealmSwift


// MARK: - Input

protocol RegisterTodoDataStoreInput: AnyObject {
    func registerTodoRequest(inputText: String, completion: @escaping(Result<Void, Error>) -> Void)
}

final class RegisterTodoDataStore: RegisterTodoDataStoreInput {
    
    func registerTodoRequest(inputText: String, completion: @escaping(Result<Void, Error>) -> Void) {
        let currentTime = Date()
        let todoModel: TodoModel = TodoModel()
        todoModel.title = inputText
        todoModel.regDate = currentTime
        let realmDb = try! Realm()
        
        try! realmDb.write({
            realmDb.add(todoModel)
            completion(.success(()))
        })
    }
}
