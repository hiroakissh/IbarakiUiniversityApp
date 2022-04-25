//
//  AddToDoViewController.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2021/10/07.
//

import UIKit
import RealmSwift

class AddToDoViewController: UIViewController {
    @IBOutlet private weak var newTextField: UITextField!
    @IBOutlet private weak var addButton: UIButton!

    let todoRepository = ToDoRepository()

    override func viewDidLoad() {
        super.viewDidLoad()

        addButton.layer.cornerRadius = 20.0
        newTextField.layer.borderWidth = 2.0
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction private func addToDo(_ sender: Any) {
        if newTextField.text?.isEmpty != true {
            // Repositoryを使用したデータ保存
            todoRepository.appendLabToDo(todo: newTextField.text ?? "", uuid: newTextField.text ?? "")
            do {
                let realm = try Realm()
                let labToDo = ToDoModel()
                labToDo.labTODO = newTextField?.text
                try realm.write {
                    realm.add(labToDo)
                }
                dismiss(animated: true)
            } catch {
                print("Error realm")
            }
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
            message: "TODO名が空です\n TODOを追加するには名前を記入してください。",
            preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in self.viewDidLoad()})

        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
