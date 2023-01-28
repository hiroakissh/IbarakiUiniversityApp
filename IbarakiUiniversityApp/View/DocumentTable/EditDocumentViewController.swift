//
//  EditDocumentViewController.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2023/01/01.
//

import UIKit

class EditDocumentViewController: UIViewController {
    @IBOutlet private weak var documentNameTextField: UITextField!
    @IBOutlet private weak var documentDataPicker: UIDatePicker!

    var editDocumentUUID: String?
    var documentRepository = DocumentRepository()

    var documentSwiftModel: SwiftDocumentModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let editDocumentUUID = editDocumentUUID else { return }
        documentSwiftModel = documentRepository.loadDocumentOfUUID(uuid: editDocumentUUID)
        documentNameTextField.text = documentSwiftModel?.documentTitle
        let deadLine = documentSwiftModel?.deadLine
        guard let deadLine = deadLine else { return }
        documentDataPicker.date = deadLine
    }

    @IBAction private func uodateDocument(_ sender: Any) {
    }
    @IBAction private func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
}
