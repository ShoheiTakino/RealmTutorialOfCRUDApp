//
//  TodoListPresenter.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/24.
//

import Foundation

// MARK: - Input

protocol TodoListPresenterInput: AnyObject {
    func viewDidLoad()
    
    // MARK: Action
    func tappedStoreButton(inputText: String)
    func tappedSortButton(queryTitle: String)
    func selectedTodoCell(todo: TodoModel)
    func tappedDeleteAllTodosList()
    func pulledTableView()
    
    // MARK: DelegateAction
    func updatedTodoItem()
}

// MARK: - Output

protocol TodoListPresenterOutput: AnyObject {
    func showTodoList(todos: [TodoModel])
    func refreshTdodosList(todos: [TodoModel])
    func presentTodoDetaileVC(todo: TodoModel)
}

// MARK: - Presenter

final class TodoListPresenter {
    private weak var view: TodoListPresenterOutput?
    private let registerTodoUseCase: RegisterTodoUseCaseInput
    
    init(view: TodoListPresenterOutput,
         registerTodoUseCase: RegisterTodoUseCaseInput) {
        self.view = view
        self.registerTodoUseCase = registerTodoUseCase
    }
}

// MARK: - TodoListPresenterInput

extension TodoListPresenter: TodoListPresenterInput {
    
    func viewDidLoad() {
        fetchTodoList()
    }
    
    func tappedStoreButton(inputText: String) {
        registerTodoUseCase.registerTodoRequest(inputText: inputText) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                strongSelf.fetchTodoList()
            case .failure:
                break
            }
        }
    }

    func tappedSortButton(queryTitle: String) {
        registerTodoUseCase.fetchTodoListWithQuery(query: queryTitle) { [weak self] result in
            guard let storngSelf = self else { return }
            switch result {
            case .success(let list):
                storngSelf.view?.showTodoList(todos: list)
            case .failure:
                break
            }
        }
    }
    
    func selectedTodoCell(todo: TodoModel) {
        view?.presentTodoDetaileVC(todo: todo)
    }
    
    func pulledTableView() {
        fetchTodoList()
    }
    
    func updatedTodoItem() {
        fetchTodoList()
    }
    
    func tappedDeleteAllTodosList() {
        registerTodoUseCase.deleteAllTodosRequest { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                strongSelf.view?.refreshTdodosList(todos: [])
            case .failure:
                break
            }
        }
    }
}

private extension TodoListPresenter {
    
    func fetchTodoList() {
        registerTodoUseCase.fetchTodoList { [weak self] result in
            guard let strongsSelf = self else { return }
            switch result {
            case .success(let list):
                strongsSelf.view?.showTodoList(todos: list)
            case .failure:
                break
            }
        }
    }
}
