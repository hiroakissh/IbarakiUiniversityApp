//
//  AddDocumentViewController.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2021/10/05.
//

import UIKit
import RealmSwift

class AddDocumentViewController: UIViewController {
    @IBOutlet private weak var newDocumentTextField: UITextField!
    @IBOutlet private weak var addButon: UIButton!
    @IBOutlet private weak var datePicker: UIDatePicker!

    let documentInfo = Documentinfo()
    var list: Results<SubmitDocumentList>!

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

        do {
            let realm = try Realm()
            list = realm.objects(SubmitDocumentList.self)
        } catch {
            print("Error")
        }
    }

    func uiSetting () {
        addButon.layer.cornerRadius = 5.0
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction private func addDocument(_ sender: Any) {
        if newDocumentTextField.text?.isEmpty != true {
            do {
                documentInfo.documentToDo = newDocumentTextField.text ?? ""
                documentInfo.deadline = datePicker.date

                let realm = try Realm()
                try realm.write {
                    if list.isEmpty {
                        let documentList = SubmitDocumentList()
                        documentList.documentToDos.append(documentInfo)
                        realm.add(documentList)
                    } else {
                        list[0].documentToDos.append(documentInfo)
                    }
                }
                dismiss(animated: true)
            } catch {
                print("Error realm")
            }
            dismiss(animated: true, completion: nil)
        } else {
            presentAlert()
        }
    }

    @IBAction private func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
