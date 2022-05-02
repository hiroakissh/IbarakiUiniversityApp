//
//  RealmDocumentModel.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2022/04/23.
//

import Foundation
import RealmSwift

class RealmDocumentModel: Object {
    @objc dynamic var documentUUID = ""
    @objc dynamic var documentTitle: String?
    @objc dynamic var deadLine: Date?

    var uuid: UUID? {
        UUID(uuidString: documentUUID)
    }

    override class func primaryKey() -> String? {
        "documentUUID"
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
        self.uuidString = managedObject.documentUUID
        self.documentTitle = managedObject.documentTitle
        self.deadLine = managedObject.deadLine
    }

    func managedObject() -> RealmDocumentModel {
        let realmDocumentModel = RealmDocumentModel()
        realmDocumentModel.documentUUID = self.uuidString
        realmDocumentModel.documentTitle = self.documentTitle
        realmDocumentModel.deadLine = self.deadLine
        return realmDocumentModel
    }
}
