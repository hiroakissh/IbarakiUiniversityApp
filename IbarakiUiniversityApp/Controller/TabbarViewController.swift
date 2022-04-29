//
//  TabbarViewController.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2021/10/07.
//

import UIKit

enum TabBarItems {
    case submitDocument
    case labTodo
    case portal
    case manaba
}

class TabbarViewController: UITabBarController {
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
        let application = UIApplication.shared
        print(self.selectedIndex)
        // TODO: アイテムに追加や削除があったときに呼ぶ
        addBadgeValue(item: .submitDocument, app: application)
    }

    func addBadgeValue(item: TabBarItems, app: UIApplication) {
        let tabBarItems: TabBarItems = item

        switch tabBarItems {
        case .submitDocument:
            let submitDocumentTabItem: UITabBarItem = tabBar.items![0]
            // TODO: valueにアイテムの数を入れる
            let documentItems = documentRepository.loadDocument()
            submitDocumentTabItem.badgeValue = String(documentItems.count)
        case .labTodo:
            let labToDoTabItem: UITabBarItem = tabBar.items![1]
            let labToDoItems = todoRepository.loadLabToDo()
            labToDoTabItem.badgeValue = String(labToDoItems.count)
        default :
            print("manabaかポータルだね")
        }
        // TODO: Itemのトータルを入れる
        app.applicationIconBadgeNumber = 10
    }
}
