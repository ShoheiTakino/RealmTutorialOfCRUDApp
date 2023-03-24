//
//  NSObjectProtocol+.swift
//  RealmTutorialOfCRUDApp
//
//  Created by 滝野翔平 on 2023/03/24.
//

import Foundation

extension NSObjectProtocol {

    static var className: String {
        return String(describing: self)
    }

}
