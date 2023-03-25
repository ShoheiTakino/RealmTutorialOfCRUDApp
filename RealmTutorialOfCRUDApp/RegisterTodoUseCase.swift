//
//  RegisterTodoUseCase.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/24.
//

import Foundation

// MARK: - Input

protocol RegisterTodoUseCaseInput: AnyObject {
    func registerTodoRequest(inputText: String, completion: @escaping(Result<Void, Error>) -> Void)
    func fetchTodoList(completion: @escaping (Result<[TodoModel], Error>) -> Void)
    func deleteAllTodosRequest(completion: @escaping (Result<Void, Error>) -> Void)
    func fetchTodoListWithQuery(query: String, completion: @escaping (Result<[TodoModel], Error>) -> Void)
}

// MARK: - UseCase

final class RegisterTodoUseCase {
    
    private let registerTodoDataStore: RegisterTodoDataStoreInput
    private let fetchTodoListDataStore: FetchTodoListDataStoreInput
    private let deleteAllTodosDataStore: DeleteAllTodosDataStoreInput
    private let fetchTodoListWithQueryDataStore: FetchTodoListWithQueryDataStoreInput
    
    init(registerTodoDataStore: RegisterTodoDataStoreInput,
         fetchTodoListDataStore: FetchTodoListDataStoreInput,
         deleteAllTodosDataStore: DeleteAllTodosDataStoreInput,
         fetchTodoListWithQueryDataStore: FetchTodoListWithQueryDataStoreInput) {
        self.registerTodoDataStore = registerTodoDataStore
        self.fetchTodoListDataStore = fetchTodoListDataStore
        self.deleteAllTodosDataStore = deleteAllTodosDataStore
        self.fetchTodoListWithQueryDataStore = fetchTodoListWithQueryDataStore
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
    
    func fetchTodoListWithQuery(query: String, completion: @escaping (Result<[TodoModel], Error>) -> Void) {
        fetchTodoListWithQueryDataStore.fetchTodoListWithQuery(query: query) { result in
            completion(result)
        }
    }
    
    func deleteAllTodosRequest(completion: @escaping (Result<Void, Error>) -> Void) {
        deleteAllTodosDataStore.deleteAllTodosRequest { result in
            completion(result)
        }
    }
}
