//
//  LabViewController.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2021/10/01.
//

import UIKit
import RealmSwift

class LabViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    var toDoItems: Results<ToDoModel>!

    var todoRepository = ToDoRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "LabToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "todoCell")

        do {
            let realm = try Realm()
            toDoItems = realm.objects(ToDoModel.self)
        } catch {
            print("Error")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension LabViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if toDoItems.isEmpty {
            return 1
        } else {
            return toDoItems.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard toDoItems.count != 0
        else {
            let noneCell = tableView.dequeueReusableCell(withIdentifier: "todononeCell", for: indexPath)
            noneCell.textLabel?.text = "現在タスクがありません"
            noneCell.textLabel?.textAlignment = .center
            noneCell.textLabel?.textColor = .white
            noneCell.textLabel?.backgroundColor = .darkGray
            return noneCell
        }
        guard let toDoCell = tableView.dequeueReusableCell(
            withIdentifier: "todoCell",
            for: indexPath
        ) as? LabToDoTableViewCell
        else {
            return UITableViewCell()
        }
        let toDoObject = toDoItems[indexPath.row]
        toDoCell.todoLabel?.text = toDoObject.labTODO
        return toDoCell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if toDoItems != nil {
                deleteLabToDo(at: indexPath.row)
                tableView.reloadData()
            } else {
                return
            }
        }
    }
    func deleteLabToDo (at index: Int) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(toDoItems[index])
            }
        } catch {
            print("Error")
        }
    }
}

extension LabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
