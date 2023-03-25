//
//  FetchTodoListWithQueryDataStore.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/25.
//

import Foundation
import RealmSwift

// MARK: - Input

protocol FetchTodoListWithQueryDataStoreInput: AnyObject {
    func fetchTodoListWithQuery(query: String, completion: @escaping (Result<[TodoModel], Error>) -> Void)
}

final class FetchTodoListWithQueryDataStore: FetchTodoListWithQueryDataStoreInput {
    
    func fetchTodoListWithQuery(query: String, completion: @escaping (Result<[TodoModel], Error>) -> Void) {
        var todosList: Results<TodoModel>
        let realmDb = try! Realm()
        todosList = realmDb.objects(TodoModel.self).filter("title == '\(query)'")
        completion(.success(RealmDBConverter.convertToModelFrom(object: todosList)))
    }
}
