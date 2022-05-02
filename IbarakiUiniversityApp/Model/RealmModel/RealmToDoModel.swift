//
//  RealmToDoModel.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2022/04/24.
//

import Foundation
import RealmSwift

class RealmToDoModel: Object {
    @objc dynamic var todoUUID = ""
    @objc dynamic var labTODO: String?

    var uuid: UUID? {
        UUID(uuidString: todoUUID)
    }

    override class func primaryKey() -> String? {
        "todoUUID"
    }

    convenience init(labToDo: String) {
        self.init()
        self.labTODO = labToDo
    }
}

private extension SwiftLabToDoModel {
    init(managedObject: RealmToDoModel) {
        self.uuidString = managedObject.todoUUID
        self.labToDo = managedObject.labTODO
    }

    func managedObject() -> RealmToDoModel {
        let realmToDoModel = RealmToDoModel()
        realmToDoModel.todoUUID = self.uuidString
        realmToDoModel.labTODO = self.labToDo
        return realmToDoModel
    }
}
