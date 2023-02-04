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
    @IBOutlet private weak var updateButton: UIButton!

    var editDocumentUUID: String?
    var documentRepository = DocumentRepository()

    var documentSwiftModel: SwiftDocumentModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        guard let editDocumentUUID = editDocumentUUID else { return }
        documentSwiftModel = documentRepository.loadDocumentOfUUID(uuid: editDocumentUUID)
        documentNameTextField.text = documentSwiftModel?.documentTitle
        let deadLine = documentSwiftModel?.deadLine
        guard let deadLine = deadLine else { return }
        documentDataPicker.date = deadLine
    }

    private func setupUI() {
        updateButton.layer.cornerRadius = 10
    }

    @IBAction private func updateDocument(_ sender: Any) {
        print("データの更新")

        documentSwiftModel?.documentTitle = documentNameTextField.text
        documentSwiftModel?.deadLine = documentDataPicker.date
        guard let editDocumentUUID = editDocumentUUID,
              let documentSwiftModel = documentSwiftModel
        else { return }
        switch documentRepository.updateDocument(
            uuid: editDocumentUUID,
            updateDocument: documentSwiftModel
        ) {
        case .success(_):
            self.navigationController?.popToRootViewController(animated: true)
        case .failure(let error):
            print(error)
        }
    }
}
