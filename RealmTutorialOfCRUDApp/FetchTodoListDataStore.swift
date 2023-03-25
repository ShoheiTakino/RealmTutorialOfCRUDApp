//
//  FetchTodoListDataStore.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/24.
//

import Foundation
import RealmSwift


// MARK: - Input

protocol FetchTodoListDataStoreInput: AnyObject {
    func fetchTodoList(completion: @escaping (Result<[TodoModel], Error>) -> Void)
}

final class FetchTodoListDataStore: FetchTodoListDataStoreInput {
    
    func fetchTodoList(completion: @escaping (Result<[TodoModel], Error>) -> Void) {
        var todosList: Results<TodoModel>
        let realmDb = try! Realm()
        todosList = realmDb.objects(TodoModel.self)
        completion(.success(RealmDBConverter.convertToModelFrom(object: todosList)))
    }
}

//private extension FetchTodoListDataStore {
//    
//    func converterToTodoModelList(item: Results<TodoModel>) -> [TodoModel] {
//        var todoList: [TodoModel] = []
//        for i in 0..<item.count {
//            todoList.insert(item[i], at: 0)
//        }
//        return todoList
//    }
//}
