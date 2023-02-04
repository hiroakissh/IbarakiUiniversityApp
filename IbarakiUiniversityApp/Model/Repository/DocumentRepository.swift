//
//  DocumentRepository.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2022/04/24.
//

import Foundation
import RealmSwift

enum EditDocumentsDBError: Error {
    case updateFailure
    case removeFailure
}

protocol DocumentRepositoryProtocol {
    func loadDocument() -> [SwiftDocumentModel]
    func loadDocumentOfUUID(uuid: String) -> SwiftDocumentModel
    func appendDocument(documentTitle: String, deadLine: Date)
    func removeDocument(at index: Int) -> Result<String, EditDocumentsDBError>
    func updateDocument(uuid: String, updateDocument: SwiftDocumentModel) -> Result<String, EditDocumentsDBError>
}

final class DocumentRepository: DocumentRepositoryProtocol {
    func loadDocument() -> [SwiftDocumentModel] {
        // swiftlint:disable:next force_try
        let realm = try! Realm()
        let realmDocuments = realm.objects(RealmDocumentModel.self)
        let realmDocumentsArray = Array(realmDocuments)
        let documents = realmDocumentsArray.map {SwiftDocumentModel(managedObject: $0)}
        return documents
    }

    func loadDocumentOfUUID(uuid: String) -> SwiftDocumentModel {
        // swiftlint:disable:next force_try
        let realm = try! Realm()
        let realmDocument = realm.objects(RealmDocumentModel.self).filter("documentUUID=='\(uuid)'")
        let document = SwiftDocumentModel(managedObject: realmDocument.first!)
        return document
    }

    func appendDocument(documentTitle: String, deadLine: Date) {
        // swiftlint:disable:next force_try
        let realm = try! Realm()
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

    func removeDocument(at index: Int) -> Result<String, EditDocumentsDBError>{
        // swiftlint:disable:next force_try
        let realm = try! Realm()
        let documentItems: Results<RealmDocumentModel>!
        documentItems = realm.objects(RealmDocumentModel.self)
        do {
            try realm.write {
                realm.delete(documentItems[index])
            }
        } catch {
            print("Realm Remove Error")
            return .failure(.removeFailure)
        }
        return .success("Success")
    }

    func updateDocument(uuid: String, updateDocument: SwiftDocumentModel) -> Result<String, EditDocumentsDBError> {
        // swiftlint:disable:next force_try
        let realm = try! Realm()
        let realmDocument = realm.objects(RealmDocumentModel.self).filter("documentUUID=='\(uuid)'")
        do {
            try realm.write {
                realmDocument.first?.documentTitle = updateDocument.documentTitle
                realmDocument.first?.deadLine = updateDocument.deadLine
            }
        } catch {
            return .failure(.updateFailure)
        }
        return .success("Success")
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
