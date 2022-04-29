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
    let documentInfo = Documentinfo()
    var list: Results<SubmitDocumentList>!

    func loadDocument() {

    }

    func appendDocument(documentTitle: String, deadLine: Date) {
        do {
            list = realm.objects(SubmitDocumentList.self)
            documentInfo.documentToDo = documentTitle
            documentInfo.deadline = deadLine
            try realm.write {
                if list == nil {
                    let realmDocumentList = SubmitDocumentList()
                    realmDocumentList.documentToDos.append(documentInfo)
                    realm.add(realmDocumentList)
                } else {
                    list[0].documentToDos.append(documentInfo)
                }
            }
        } catch {
            print("Realm Add Error")
        }
    }

    func removeDocument(at index: Int) {
    }

    func updateDocument() {
    }
}
