//
//  RegisterTodoUseCase.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/24.
//

import Foundation
import RealmSwift

// MARK: - Input

protocol RegisterTodoUseCaseInput: AnyObject {
    func registerTodoRequest(inputText: String, completion: @escaping(Result<Void, Error>) -> Void)
    func fetchTodoList(completion: @escaping (Result<[TodoModel], Error>) -> Void)
}

// MARK: - UseCase

final class RegisterTodoUseCase {
    private let registerTodoDataStore: RegisterTodoDataStoreInput
    private let fetchTodoListDataStore: FetchTodoListDataStoreInput
    init(registerTodoDataStore: RegisterTodoDataStoreInput,
         fetchTodoListDataStore: FetchTodoListDataStoreInput) {
        self.registerTodoDataStore = registerTodoDataStore
        self.fetchTodoListDataStore = fetchTodoListDataStore
    }
}

extension RegisterTodoUseCase: RegisterTodoUseCaseInput {
    
    func registerTodoRequest(inputText: String, completion: @escaping (Result<Void, Error>) -> Void) {
        registerTodoDataStore.registerTodoRequest(inputText: inputText) { result in
            completion(result)
        }
    }
    
    func fetchTodoList(completion: @escaping (Result<[TodoModel], Error>) -> Void) {
        fetchTodoListDataStore.fetchTodoList { result in
            completion(result)
        }
    }    
}
