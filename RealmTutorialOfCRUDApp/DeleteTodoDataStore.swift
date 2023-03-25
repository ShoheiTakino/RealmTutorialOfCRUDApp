//
//  DeleteTodoDataStore.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/25.
//

import Foundation
import RealmSwift

// MARK: - Input

protocol DeleteTodoDataStoreInput: AnyObject {
    func deleteTodoRequest(title : String, completion: @escaping(Result<Void, Error>) -> Void)
}

final class DeleteTodoDataStore: DeleteTodoDataStoreInput {
    
    func deleteTodoRequest(title : String, completion: @escaping(Result<Void, Error>) -> Void) {
        let realmDb = try! Realm()
        let todoTable = realmDb.objects(TodoModel.self)
        let result = todoTable.where({ $0.title == title }).first!
        try! realmDb.write{
            realmDb.delete(result)
            completion(.success(()))
        }
    }
}
