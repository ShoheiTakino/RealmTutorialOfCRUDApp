//
//  TodoListViewController.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/24.
//

import UIKit

final class TodoListViewController: UIViewController {
    
    // MARK: - Typealias
    
    private typealias TodoCell = TodoListTableViewCell

    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var todoListTableView: UITableView! {
        didSet {
            todoListTableView.delegate = self
            todoListTableView.dataSource = self
            todoListTableView.register(
                UINib(nibName: "TodoListTableViewCell", bundle: nil),
                forCellReuseIdentifier: "TodoListTableViewCell"
            )
            todoListTableView.registerCustomCell(TodoCell.self)
            todoListTableView.refreshControl = refreshControl
            refreshControl.addTarget(self, action: #selector(pulledTableView), for: .valueChanged)
        }
    }
    @IBOutlet private weak var registerButton: UIButton! {
        didSet {
            registerButton.layer.cornerRadius = 20
        }
    }
    @IBOutlet private weak var inputTodoTextField: UITextField! {
        didSet {
            inputTodoTextField.addTarget(self, action: #selector(textFieldDidChange),
                                         for: .editingChanged)
        }
    }
    @IBOutlet private weak var inputedTextCountLabel: UILabel!
    @IBOutlet private weak var deleteTodosListButton: UIButton! {
        didSet {
            deleteTodosListButton.layer.cornerRadius = 20
        }
    }
    @IBOutlet private weak var sortListButton: UIButton! {
        didSet {
            sortListButton.layer.cornerRadius = 20
        }
    }
    
    // MARK: - IBAction
    
    @IBAction private func tappedRegisterButton() {
        presenter.tappedStoreButton(inputText: inputtedTodo)
    }
    @IBAction private func tappedSortButton() {
        presenter.tappedSortButton(queryTitle: inputtedTodo)
    }
    @IBAction private func tappedDeleteTodosList() {
        presenter.tappedDeleteAllTodosList()
    }
    
    // MARK: - Proparty
    
    private var presenter: TodoListPresenterInput!
    private var inputtedTodo = ""
    private var todoList: [TodoModel] = []
    private var refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TodoListPresenter(view: self,
                                      registerTodoUseCase: RegisterTodoUseCase(registerTodoDataStore: RegisterTodoDataStore(),
                                                                               fetchTodoListDataStore: FetchTodoListDataStore(),
                                                                               deleteAllTodosDataStore: DeleteAllTodosDataStore(),
                                                                               fetchTodoListWithQueryDataStore: FetchTodoListWithQueryDataStore()))
        presenter.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - TodoListPresenterOutput

extension TodoListViewController: TodoListPresenterOutput {
    
    func showTodoList(todos: [TodoModel]) {
        todoList = todos
        todoListTableView.reloadData()
        inputedTextCountLabel.text = "\(0) / 20文字"
        inputTodoTextField.text = ""
        inputtedTodo = ""
        refreshControl.endRefreshing()
    }
    
    
    func presentTodoDetaileVC(todo: TodoModel) {
        let vc = TodoDetailViewController(todo: todo)
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }

    func refreshTdodosList(todos: [TodoModel]) {
        todoList = todos
        todoListTableView.reloadData()
        inputedTextCountLabel.text = "\(0) / 20文字"
        inputTodoTextField.text = ""
        inputtedTodo = ""
        refreshControl.endRefreshing()
    }
}

// MARK: - Private

private extension TodoListViewController {
    
    @objc func textFieldDidChange(sender: UITextField) {
        let inputedText = inputTodoTextField.text ?? ""
        inputedTextCountLabel.text = "\(inputedText.count) / 20文字"
        inputtedTodo = inputedText
    }
    
    @objc func pulledTableView() {
        presenter.pulledTableView()
    }
}

// MARK: -  UITableViewDataSource, UITableViewDelegate

extension TodoListViewController:  UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell") as! TodoCell
        let todo = todoList[indexPath.row]
        cell.configure(todo: todo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todoList[indexPath.row]
        presenter.selectedTodoCell(todo: todo)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UIScrollViewDelegate

extension TodoListViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

// MARK: - TodoDetailViewControllerDelegate

extension TodoListViewController: TodoDetailViewControllerDelegate {
    
    func deletedTodoItem() {
        presenter.updatedTodoItem()
    }
}
