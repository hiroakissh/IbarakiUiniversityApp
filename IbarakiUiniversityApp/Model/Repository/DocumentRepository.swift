//
//  DocumentRepository.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2022/04/24.
//

import Foundation
import RealmSwift

final class DocumentRepository {
    // swiftlint:disable force_try
    private let realm = try! Realm()

    func loadDocument() -> [SwiftDocumentModel] {
        let realmDocuments = realm.objects(RealmDocumentModel.self)
        let realmDocumentsArray = Array(realmDocuments)
        let documents = realmDocumentsArray.map {SwiftDocumentModel(managedObject: $0)}
        return documents
    }

    func appendDocument(documentTitle: String, deadLine: Date) {
        let realmDocument = RealmDocumentModel()
        let uuid = UUID()
        realmDocument.documentUUID = uuid.uuidString
        realmDocument.documentTitle = documentTitle
        realmDocument.deadLine = deadLine
        do {
            try realm.write {
                realm.add(realmDocument)
            }
        } catch {
            print("Realm Add Error")
            return
        }
        print(realmDocument)
    }

    func removeDocument(at index: Int) {
        let documentItems: Results<RealmDocumentModel>!
        documentItems = realm.objects(RealmDocumentModel.self)
        do {
            try realm.write {
                realm.delete(documentItems[index])
            }
        } catch {
            print("Realm Remove Error")
        }
    }

    func updateDocument() {
    }
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
