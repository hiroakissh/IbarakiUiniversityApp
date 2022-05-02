//
//  LabViewController.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2021/10/01.
//

import UIKit

class LabViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    private let delegate = UIApplication.shared.delegate as? AppDelegate

    var todoRepository = ToDoRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "LabToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "todoCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        updateBadge()
    }

    @IBAction private func exitCancel(segue: UIStoryboardSegue) {
    }

    private func updateBadge() {
        let app = UIApplication.shared
        let todoItems = todoRepository.loadLabToDo()
        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[1]
            tabItem.badgeValue = String(todoItems.count)
        }
        delegate?.todoCount = todoItems.count
        let totalCount: Int = (delegate?.todoCount ?? 0) + (delegate?.documentCount ?? 0)
        app.applicationIconBadgeNumber = totalCount
    }
}

extension LabViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let labToDoItems = todoRepository.loadLabToDo()
        if labToDoItems.isEmpty {
            return 1
        } else {
            return labToDoItems.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let labToDoItems = todoRepository.loadLabToDo()
        guard labToDoItems.count != 0
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
        let toDoObject = labToDoItems[indexPath.row]
        toDoCell.todoLabel?.text = toDoObject.labToDo
        return toDoCell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        let labToDoItems = todoRepository.loadLabToDo()
        if editingStyle == .delete {
            if !labToDoItems.isEmpty {
                deleteLabToDo(at: indexPath.row)
                tableView.reloadData()
                updateBadge()
            } else {
                return
            }
        }
    }
    func deleteLabToDo (at index: Int) {
        todoRepository.removeLabToDo(at: index)
    }
}

extension LabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
