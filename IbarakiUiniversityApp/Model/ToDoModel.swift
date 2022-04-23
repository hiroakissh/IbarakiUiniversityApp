//
//  ToDoModel.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2021/10/09.
//

import Foundation
import RealmSwift

protocol ExchangeData {
    func receveData ()
    func tranceData ()
}

class ToDoModel: Object {
    @objc dynamic var labTODO: String?
}

class ExchangeToDoModel: ExchangeData {
    var toDoItems: Results<ToDoModel>!

    func receveData() {
        <#code#>
    }

    func tranceData() {
        <#code#>
    }
}
