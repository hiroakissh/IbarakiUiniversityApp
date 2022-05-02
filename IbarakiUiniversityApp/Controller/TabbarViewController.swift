//
//  TabbarViewController.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2021/10/07.
//

import UIKit

class TabBarViewController: UITabBarController {
    var todoRepository = ToDoRepository()
    var documentRepository = DocumentRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 0

        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge]) { _, error in
            if let error = error {
                print(error)
            }
        }
        let todoItems = todoRepository.loadLabToDo()
        let documentItems = documentRepository.loadDocument()

        if todoItems.count == 0 {
            tabBar.items?[1].badgeValue = nil
        } else {
            tabBar.items?[0].badgeValue = "\(String(todoItems.count))"
        }

        if documentItems.count == 0 {
            tabBar.items?[0].badgeValue = nil
        } else {
            tabBar.items?[1].badgeValue = "\(String(documentItems.count))"
        }
    }
}
