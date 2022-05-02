//
//  AddDocumentViewController.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2021/10/05.
//

import UIKit

class AddDocumentViewController: UIViewController {
    @IBOutlet private weak var newDocumentTextField: UITextField!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var datePicker: UIDatePicker!

    var documentRepository = DocumentRepository()

    var picker: UIDatePicker = UIDatePicker()

    struct SubmitDocument {
        var documentName: String?
        var submitDate: Date?

        init (documentName: String, submitDate: Date) {
            guard documentName != "" else {
                return
            }
            self.documentName = documentName
            self.submitDate = submitDate
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetting()
    }

    func uiSetting () {
        addButton.layer.cornerRadius = 5.0
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction private func addDocument(_ sender: Any) {
        if newDocumentTextField.text?.isEmpty != true {
            let documentTitle = newDocumentTextField.text ?? ""
            let deadLine = datePicker.date
            documentRepository.appendDocument(documentTitle: documentTitle, deadLine: deadLine)
            dismiss(animated: true)
        } else {
            presentAlert()
        }
    }

    private func presentAlert() {
        let alert = UIAlertController(
            title: "注意",
            message: "提出物名が空です\n提出物を追加するには記入してください。",
            preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in self.viewDidLoad()})

        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension AddDocumentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
