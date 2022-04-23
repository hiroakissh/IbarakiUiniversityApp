//
//  DocumentModel.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2021/10/09.
//

import Foundation
import RealmSwift

class Documentinfo: Object {
    @objc dynamic var documentToDo: String = ""
    @objc dynamic var deadline: Date = Date()
}

class SubmitDocumentList: Object {
    let documentToDos = List<Documentinfo>()
}
