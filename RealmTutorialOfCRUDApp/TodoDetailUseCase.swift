//
//  TodoDetailUseCase.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/25.
//

import Foundation
// MARK: - Input

protocol TodoDetailUseCaseInput: AnyObject {
    func updateTodoRequest(inputText: String, completion: @escaping(Result<Void, Error>) -> Void)
    func deleteTodoRequest(title : String, completion: @escaping(Result<Void, Error>) -> Void)
}

// MARK: - UseCase

final class TodoDetailUseCase {
    private let updateTodoDataStore: UpdateTodoDataStoreInput
    private let deleteTodoDataStore: DeleteTodoDataStoreInput
    
    init(updateTodoDataStore: UpdateTodoDataStoreInput,
         deleteTodoDataStore: DeleteTodoDataStoreInput) {
        self.updateTodoDataStore = updateTodoDataStore
        self.deleteTodoDataStore = deleteTodoDataStore
    }
}

// MARK: - TodoDetailUseCaseInput

extension TodoDetailUseCase: TodoDetailUseCaseInput {
    
    func updateTodoRequest(inputText: String, completion: @escaping (Result<Void, Error>) -> Void) {
        updateTodoDataStore.updateTodoRequest(inputText: inputText) { result in
            completion(result)
        }
    }
    
    func deleteTodoRequest(title : String, completion: @escaping(Result<Void, Error>) -> Void) {
        deleteTodoDataStore.deleteTodoRequest(title: title) { result in
            completion(result)
        }
    }
}
