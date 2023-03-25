//
//  TodoDetailViewController.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/25.
//

import UIKit

// MARK: - TodoDetailViewControllerDelegate

protocol TodoDetailViewControllerDelegate: AnyObject {
    func deletedTodoItem()
}

final class TodoDetailViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var newInputTodoTextField: UITextField! {
        didSet {
            newInputTodoTextField.addTarget(self, action: #selector(textFieldDidChange),
                                         for: .editingChanged)
        }
    }
    
    @IBOutlet private weak var updateTodoButton: UIButton! {
        didSet {
            updateTodoButton.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet private weak var deleteTodoButton: UIButton! {
        didSet {
            deleteTodoButton.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet private weak var backButton: UIButton! {
        didSet {
            backButton.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet private weak var inputTextCountLabel: UILabel!
    
    // MARK: - IBAction
    
    @IBAction private func tappedUpdateButton() {
        presenter?.tappedUpdateButton(newTitle: newInputTodoText)
    }
    
    @IBAction private func tappedDeleteButton() {
        presenter?.tappedDeleteTodoButton()
    }
    
    @IBAction private func tappedBackButton() {
        presenter?.tappedBackButton()
    }
    
    // MARK: - Propartyycle
    
    private let todo: TodoModel
    private var presenter: TodoDetailPresenterInput?
    weak var delegate: TodoDetailViewControllerDelegate?
    private var newInputTodoText = ""
    
    
    // MARK: - Initialize
    
    init(todo: TodoModel) {
        self.todo = todo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifec
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TodoDetailPresenter(view: self,
                                        todoDetailUseCase: TodoDetailUseCase(updateTodoDataStore: UpdateTodoDataStore(),
                                                                             deleteTodoDataStore: DeleteTodoDataStore()))
        presenter?.viewDidLoad(todo: todo)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - TodoDetailPresenterOutput

extension TodoDetailViewController: TodoDetailPresenterOutput {
    
    func showNoUpdateAlert(title: String) {
        print(title)
    }
    
    func setup(todo: TodoModel) {
        let currentTodoTitle = todo.title ?? ""
        newInputTodoText = currentTodoTitle
        newInputTodoTextField.text = currentTodoTitle
        inputTextCountLabel.text = "\(currentTodoTitle.count) / 20文字"
    }
    
    func dismissDetaileVC() {
        delegate?.deletedTodoItem()
        dismiss(animated: true)
    }
}

// MARK: - Private

private extension TodoDetailViewController {
    
    @objc func textFieldDidChange(sender: UITextField) {
        let inputedText = newInputTodoTextField.text ?? ""
        inputTextCountLabel.text = "\(inputedText.count) / 20文字"
        newInputTodoText = inputedText
    }
}
