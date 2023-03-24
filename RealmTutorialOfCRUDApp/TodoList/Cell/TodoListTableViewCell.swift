//
//  TodoListTableViewCell.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/24.
//

import UIKit

final class TodoListTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    func configure(todo: TodoModel) {
        titleLabel.text = todo.title
        dateLabel.text = todo.regDate?.formatted(.dateTime)
    }
}
