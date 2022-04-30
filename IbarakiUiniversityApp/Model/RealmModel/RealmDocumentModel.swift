//
//  RealmDocumentModel.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2022/04/23.
//

import Foundation
import RealmSwift

class RealmDocumentModel: Object {
    @objc dynamic var uuidString = ""
    @objc dynamic var documentTitle = ""
    @objc dynamic var deadLine: Date = Date()

    var uuid: UUID? {
        UUID(uuidString: uuidString)
    }

    override class func primaryKey() -> String? {
        "uuidString"
    }

    convenience init(documentTitle: String, deadLine: Date) {
        self.init()
        self.documentTitle = documentTitle
        self.deadLine = deadLine
    }
}

class RealmSubmitDocumentList: Object {
    let documentToDos = List<RealmDocumentModel>()
}

private extension SwiftDocumentModel {
    init(managedObject: RealmDocumentModel) {
        self.uuidString = managedObject.uuidString
        self.documentTitle = managedObject.documentTitle
        self.deadLine = managedObject.deadLine
    }

    func managedObject() -> RealmDocumentModel {
        let realmDocumentModel = RealmDocumentModel()
        realmDocumentModel.uuidString = self.uuidString
        realmDocumentModel.documentTitle = self.documentTitle
        realmDocumentModel.deadLine = self.deadLine
        return realmDocumentModel
    }
}
