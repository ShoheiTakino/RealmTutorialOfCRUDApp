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
    
    func tappedStoreButton(inputText: String)
    func selectedTodoCell(todo: TodoModel)
    func updatedTodoItem()
    func tappedDeleteAllTodosList()
}

// MARK: - Output

protocol TodoListPresenterOutput: AnyObject {
    func setupUI()
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
        view?.setupUI()
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
    
    func selectedTodoCell(todo: TodoModel) {
        view?.presentTodoDetaileVC(todo: todo)
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
