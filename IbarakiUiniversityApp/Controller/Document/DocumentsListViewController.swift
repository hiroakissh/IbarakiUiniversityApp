//
//  DocumentsListViewController.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2021/10/01.
//

import UIKit

class DocumentsListViewController: UIViewController {
    enum DocumentStatus {
        case normal
        case befor1Week
        case befor3Day
        case befor1Day
        case deadline
        case overdue
    }

    enum DocumentCellObject {
        case none
        case document(String, Date)
    }

    @IBOutlet private weak var tableView: UITableView!

    private weak var delegate = UIApplication.shared.delegate as? AppDelegate

    private var documentRepository = DocumentRepository()

    private var documentCellObject: [DocumentCellObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DocumentTableViewCell", bundle: nil), forCellReuseIdentifier: "documentCell")
        observeDocumentCellObject()
    }

    func observeDocumentCellObject() {
        let documentItems = documentRepository.loadDocument()
        if documentItems.isEmpty {
            documentCellObject = [.none]
        } else {
            documentCellObject = documentItems.map {
                .document($0.documentTitle ?? "提出物が正しく表示できません", $0.deadLine ?? Date.now )
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observeDocumentCellObject()
        tableView.reloadData()
        updateBadge()
    }

    @IBAction private func exitCancel(segue: UIStoryboardSegue) {
    }

    private func updateBadge() {
        let app = UIApplication.shared
        let documentItems = documentRepository.loadDocument()
        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[0]
            if documentItems.count == 0 {
                tabItem.badgeValue = nil
            } else {
                tabItem.badgeValue = String(documentItems.count)
            }
        }
        delegate?.documentCount = documentItems.count
        let totalCount: Int = (delegate?.todoCount ?? 0) + (delegate?.documentCount ?? 0)
        app.applicationIconBadgeNumber = totalCount
    }

    private func notification() {
        let documentItems = documentRepository.loadDocument()
        for documentItem in documentItems {
            let content = UNMutableNotificationContent()
            content.sound = .default
            content.title = documentItem.documentTitle ?? ""
            content.subtitle = "締め切りが迫ってます。早めに済ませましょう"
            content.body = "締め切りが過ぎたら土下座です"

            // 午前の通知
            var morning = DateComponents()
            morning.hour = 8
            morning.minute = 0
            let identifier = String(documentItem.uuidString)
            let morningTrigger = UNCalendarNotificationTrigger(dateMatching: morning, repeats: false)
            let morningRequest = UNNotificationRequest(
                identifier: identifier,
                content: content,
                trigger: morningTrigger
            )
            UNUserNotificationCenter.current().add(morningRequest) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
            // 午後の通知
            let afternoon = DateComponents()
            morning.hour = 17
            morning.minute = 0
            let afternoonTrigger = UNCalendarNotificationTrigger(dateMatching: afternoon, repeats: false)
            let afternoonRequest = UNNotificationRequest(
                identifier: identifier,
                content: content,
                trigger: afternoonTrigger
            )
            UNUserNotificationCenter.current().add(afternoonRequest) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension DocumentsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        documentCellObject.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch documentCellObject[indexPath.row] {
        case .none:
            let noneCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            noneCell.textLabel?.text = "予定されている提出物がありません"
            noneCell.textLabel?.textAlignment = .center
            noneCell.textLabel?.textColor = .white
            noneCell.textLabel?.backgroundColor = .darkGray
            return noneCell
        case .document(let name, let date):
            let documentCell = tableView.dequeueReusableCell(
                withIdentifier: "documentCell",
                for: indexPath
                // swiftlint:disable:next force_cast
            ) as! DocumentTableViewCell
            documentCell.documentNameLabel?.text = name
            documentCell.deadlineLabel.text = diffDate(date: date)
            return documentCell
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        let documentItems = documentRepository.loadDocument()
        if editingStyle == .delete {
            if !documentItems.isEmpty {
                documentRepository.removeDocument(at: indexPath.row)
                tableView.reloadData()
                updateBadge()
            } else {
                return
            }
        }
        if editingStyle == .none {
        }
    }

    private func diffDate(date: Date) -> String {
        let now = Date()
        let calendar = Calendar(identifier: .gregorian)
        let diff = calendar.dateComponents([.day], from: now, to: date)
        guard let diffDay = diff.day else {
            return "提出期限が設定されていません"
        }
        if diffDay > 0 {
            return "締め切りまで \(diffDay) 日です"
        } else if diffDay == 0 {
            return "今日が提出期限です"
        } else {
            return "提出期限が過ぎています"
        }
    }
}

extension DocumentsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
