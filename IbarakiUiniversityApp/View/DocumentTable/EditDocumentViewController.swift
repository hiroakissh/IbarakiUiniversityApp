//
//  EditDocumentViewController.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2023/01/01.
//

import UIKit

class EditDocumentViewController: UIViewController {

    var editDocumentUUID: String?
    var documentRepository = DocumentRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(editDocumentUUID)
        guard let editDocumentUUID = editDocumentUUID else { return }
        print(documentRepository.loadDocumentOfUUID(uuid: editDocumentUUID))
    }
}
