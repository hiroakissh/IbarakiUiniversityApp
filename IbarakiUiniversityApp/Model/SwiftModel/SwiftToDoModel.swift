//
//  SwiftToDoModel.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2022/04/23.
//

import Foundation

struct SwiftLabToDoModel {
    var uuid: UUID? {
        UUID(uuidString: uuidString)
    }
    var uuidString = UUID().uuidString
    var labToDo: String?
}
