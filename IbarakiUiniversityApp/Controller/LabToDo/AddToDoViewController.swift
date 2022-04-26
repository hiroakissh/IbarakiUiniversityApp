//
//  AddToDoViewController.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2021/10/07.
//

import UIKit

class AddToDoViewController: UIViewController {
    @IBOutlet private weak var newTextField: UITextField!
    @IBOutlet private weak var addButton: UIButton!

    private let todoRepository = ToDoRepository()

    override func viewDidLoad() {
        super.viewDidLoad()

        addButton.layer.cornerRadius = 20.0
        newTextField.layer.borderWidth = 2.0
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction private func addToDo(_ sender: Any) {
        if let addToDoText = newTextField.text {
            if addToDoText == "" {
                presentAlert()
                return
            } else {
                todoRepository.appendLabToDo(todo: addToDoText)
            }
        } else {
            return
        }
        dismiss(animated: true)
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
