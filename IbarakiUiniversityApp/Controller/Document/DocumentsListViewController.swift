//
//  DocumentsListViewController.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2021/10/01.
//

import UIKit

class DocumentsListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    private let delegate = UIApplication.shared.delegate as? AppDelegate

    var documentRepository = DocumentRepository()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DocumentTableViewCell", bundle: nil), forCellReuseIdentifier: "documentCell")
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
        let documentItems = documentRepository.loadDocument()
        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[0]
            tabItem.badgeValue = String(documentItems.count)
        }
        delegate?.documentCount = documentItems.count
        let totalCount: Int = (delegate?.todoCount ?? 0) + (delegate?.documentCount ?? 0)
        app.applicationIconBadgeNumber = totalCount
    }
}

extension DocumentsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let documentItems = documentRepository.loadDocument()
        if documentItems.isEmpty {
            return 1
        } else {
            return documentItems.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let documentItems = documentRepository.loadDocument()
        guard documentItems.count != 0
        else {
            let noneCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            noneCell.textLabel?.text = "予定されている提出物がありません"
            noneCell.textLabel?.textAlignment = .center
            noneCell.textLabel?.textColor = .white
            noneCell.textLabel?.backgroundColor = .darkGray
            return noneCell
        }

        guard let documentCell = tableView.dequeueReusableCell(
            withIdentifier: "documentCell",
            for: indexPath
        ) as? DocumentTableViewCell
        else {
            return UITableViewCell()
        }
        documentCell.documentNameLabel?.text = documentItems[indexPath.row].documentTitle
        documentCell.deadlineLabel.text = diffDate(indexRow: indexPath.row)
        return documentCell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            documentRepository.removeDocument(at: indexPath.row)
        }
        tableView.reloadData()
        updateBadge()
    }

    func diffDate(indexRow: Int) -> String {
        let documentItems = documentRepository.loadDocument()
        let now = Date()
        let calender = Calendar(identifier: .gregorian)
        let submitDate = documentItems[indexRow].deadLine
        let diff = calender.dateComponents([.day], from: now, to: submitDate ?? now)
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
