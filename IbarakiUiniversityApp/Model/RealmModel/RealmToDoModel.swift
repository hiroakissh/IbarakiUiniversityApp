//
//  RealmToDoModel.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2022/04/24.
//

import Foundation
import RealmSwift

class RealmToDo: Object {
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
    init(managedObject: RealmToDo) {
        self.uuidString = managedObject.uuidString
        self.labToDo = managedObject.labTODO
    }

    func managedObject() -> RealmToDo {
        let realmToDo = RealmToDo()
        realmToDo.uuidString = self.uuidString
        realmToDo.labTODO = self.labToDo
        return realmToDo
    }
}
