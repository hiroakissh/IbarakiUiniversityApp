//
//  RealmToDoModel.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2022/04/24.
//

import Foundation
import RealmSwift

class RealmToDoModel: Object {
    @objc dynamic var uuidString = ""
    @objc dynamic var labTODO: String?

    var uuid: UUID? {
        UUID(uuidString: uuidString)
    }

    override class func primaryKey() -> String? {
        "uuidString"
    }

    convenience init(labToDo: String) {
        self.init()
        self.labTODO = labToDo
    }
}

private extension SwiftLabToDo {
    init(managedObject: RealmToDoModel) {
        self.uuidString = managedObject.uuidString
        self.labToDo = managedObject.labTODO
    }

    func managedObject() -> RealmToDoModel {
        let realmToDo = RealmToDoModel()
        realmToDo.uuidString = self.uuidString
        realmToDo.labTODO = self.labToDo
        return realmToDo
    }
}
