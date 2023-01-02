//
//  DocumentRepository.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2022/04/24.
//

import Foundation
import RealmSwift

enum UpdateDocumentError: Error {
    case invalid
}

protocol DocumentRepositoryProtocol {
    func loadDocument() -> [SwiftDocumentModel]
    func loadDocumentOfUUID(uuid: String) -> SwiftDocumentModel
    func appendDocument(documentTitle: String, deadLine: Date)
    func removeDocument(at index: Int)
    func updateDocument(uuid: String, updateDocument: SwiftDocumentModel) -> Result<String, UpdateDocumentError>
}

final class DocumentRepository: DocumentRepositoryProtocol {
    // swiftlint:disable force_try
    private let realm = try! Realm()

    func loadDocument() -> [SwiftDocumentModel] {
        let realmDocuments = realm.objects(RealmDocumentModel.self)
        let realmDocumentsArray = Array(realmDocuments)
        let documents = realmDocumentsArray.map {SwiftDocumentModel(managedObject: $0)}
        return documents
    }

    func loadDocumentOfUUID(uuid: String) -> SwiftDocumentModel {
        let realmDocument = realm.objects(RealmDocumentModel.self).filter("documentUUID=='\(uuid)'")
        let document = SwiftDocumentModel(managedObject: realmDocument.first!)
        return document
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

    func updateDocument(uuid: String, updateDocument: SwiftDocumentModel) -> Result<String, UpdateDocumentError> {
        let realmDocument = realm.objects(RealmDocumentModel.self).filter("documentUUID=='\(uuid)'")
        do {
            try realm.write {
                realmDocument.first?.documentTitle = updateDocument.documentTitle
                realmDocument.first?.deadLine = updateDocument.deadLine
            }
        } catch {
            return .failure(.invalid)
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
