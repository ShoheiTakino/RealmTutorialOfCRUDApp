//
//  TodoDetailPresenter.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/25.
//

import Foundation

// MARK: - Input

protocol TodoDetailPresenterInput: AnyObject {
    func viewDidLoad(todo: TodoModel)
    
    func tappedUpdateButton(newTitle: String)
    func tappedDeleteTodoButton()
    func tappedBackButton()
}

// MARK: - Output

protocol TodoDetailPresenterOutput: AnyObject {
    func setup(todo: TodoModel)
    func dismissDetaileVC()
    func showNoUpdateAlert(title: String)
}

// MARK: - Presenter

final class TodoDetailPresenter {
    private weak var view: TodoDetailPresenterOutput?
    private let todoDetailUseCase: TodoDetailUseCaseInput
    private var validationTitle = ""
    
    init(view: TodoDetailPresenterOutput,
         todoDetailUseCase: TodoDetailUseCaseInput) {
        self.view = view
        self.todoDetailUseCase = todoDetailUseCase
    }
}

extension TodoDetailPresenter: TodoDetailPresenterInput {

    func viewDidLoad(todo: TodoModel) {
        validationTitle = todo.title ?? ""
        view?.setup(todo: todo)
    }
    
    func tappedUpdateButton(newTitle: String) {
        if isValidateNoChange(title: newTitle) {
            view?.showNoUpdateAlert(title: "タイトルに変更がないので変更できません")
            return
        }
        todoDetailUseCase.updateTodoRequest(inputText: newTitle) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                strongSelf.view?.dismissDetaileVC()
            case .failure:
                break
            }
        }
    }
    
    func tappedDeleteTodoButton() {
        todoDetailUseCase.deleteTodoRequest(title: validationTitle) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                strongSelf.view?.dismissDetaileVC()
            case .failure:
                break
            }
        }
    }
    
    func tappedBackButton() {
        view?.dismissDetaileVC()
    }
}

// MARK: - Private

private extension TodoDetailPresenter {
    
    func isValidateNoChange(title: String) -> Bool {
        return validationTitle == title
    }
}
