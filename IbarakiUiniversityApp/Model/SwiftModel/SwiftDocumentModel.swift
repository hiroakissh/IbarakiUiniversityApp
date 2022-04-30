//
//  SwiftDocumentModel.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2022/04/24.
//

import Foundation

struct SwiftDocumentModel {
    var uuid: UUID? {
        UUID(uuidString: uuidString)
    }
    var uuidString = UUID().uuidString
    var documentTitle: String?
    var deadLine: Date?
}
