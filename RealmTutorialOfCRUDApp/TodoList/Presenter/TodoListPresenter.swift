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
    func selectedTodoCell()
}

// MARK: - Output

protocol TodoListPresenterOutput: AnyObject {
    func setupUI()
    func showTodoList(todos: [TodoModel])
    func presentTodoDetaileVC()
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
    
    func selectedTodoCell() {
        view?.presentTodoDetaileVC()
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
