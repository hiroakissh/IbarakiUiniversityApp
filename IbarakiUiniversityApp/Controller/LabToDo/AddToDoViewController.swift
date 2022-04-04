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

    override func viewDidLoad() {
        super.viewDidLoad()

        addButton.layer.cornerRadius = 20.0
        newTextField.layer.borderWidth = 2.0
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction private func addToDo(_ sender: Any) {
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
    }

    @IBAction private func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}