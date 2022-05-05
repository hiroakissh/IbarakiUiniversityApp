//
//  LabViewController.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2021/10/01.
//

import UIKit

class LabViewController: UIViewController {

    enum ToDoCellViewObject {
        case none
        case todo(String)
    }

    @IBOutlet private weak var tableView: UITableView!

    private weak var delegate = UIApplication.shared.delegate as? AppDelegate

    private var todoRepository = ToDoRepository()

    private var todoCellViewObject: [ToDoCellViewObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "LabToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "todoCell")
        observeToDoCellObject()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observeToDoCellObject()
        tableView.reloadData()
        updateBadge()
    }

    func observeToDoCellObject() {
        let todoItems = todoRepository.loadLabToDo()
        if todoItems.isEmpty {
            todoCellViewObject = [.none]
        } else {
            todoCellViewObject = todoItems.map { .todo($0.labToDo ?? "TODOが表示できません") }
        }
    }

    @IBAction private func exitCancel(segue: UIStoryboardSegue) {
    }

    private func updateBadge() {
        let app = UIApplication.shared
        let todoItems = todoRepository.loadLabToDo()
        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[1]
            if todoItems.count == 0 {
                tabItem.badgeValue = nil
            } else {
                tabItem.badgeValue = String(todoItems.count)
            }
        }
        delegate?.todoCount = todoItems.count
        let totalCount: Int = (delegate?.todoCount ?? 0) + (delegate?.documentCount ?? 0)
        app.applicationIconBadgeNumber = totalCount
    }
}

extension LabViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoCellViewObject.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch todoCellViewObject[indexPath.row] {
        case .none:
            let noneCell = tableView.dequeueReusableCell(withIdentifier: "todononeCell", for: indexPath)
            noneCell.textLabel?.text = "現在タスクがありません"
            noneCell.textLabel?.textAlignment = .center
            noneCell.textLabel?.textColor = .white
            noneCell.textLabel?.backgroundColor = .darkGray
            return noneCell
        case .todo(let name):
            let toDoCell = tableView.dequeueReusableCell(
                withIdentifier: "todoCell",
                for: indexPath
                // swiftlint:disable:next force_cast
            ) as! LabToDoTableViewCell
            toDoCell.todoLabel?.text = name
            return toDoCell
        }
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
                todoRepository.removeLabToDo(at: indexPath.row)
                observeToDoCellObject()
                tableView.reloadData()
                updateBadge()
            } else {
                return
            }
        }
    }
}

extension LabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
