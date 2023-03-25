//
//  DeleteAllTodosDataStore.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/25.
//

import Foundation
import RealmSwift

// MARK: - Input

protocol DeleteAllTodosDataStoreInput: AnyObject {
    func deleteAllTodosRequest(completion: @escaping(Result<Void, Error>) -> Void)
}

final class DeleteAllTodosDataStore: DeleteAllTodosDataStoreInput {
    
    func deleteAllTodosRequest(completion: @escaping(Result<Void, Error>) -> Void) {
        let realmDb = try! Realm()
        
        try! realmDb.write{
            let todoModelTable = realmDb.objects(TodoModel.self)
            realmDb.delete(todoModelTable)
            completion(.success(()))
        }
    }
}
