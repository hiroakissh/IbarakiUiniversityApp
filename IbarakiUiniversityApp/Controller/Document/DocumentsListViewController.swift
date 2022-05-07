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
        case none
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
        notification()
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
        notification()
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
        let notificationRequest = UNUserNotificationCenter.current()
        notificationRequest.removeAllPendingNotificationRequests()

        let documentItems = documentRepository.loadDocument()
        if documentItems.isEmpty {
            let content = UNMutableNotificationContent()
            content.sound = .default
            content.title = "提出物はありません"
            content.subtitle = "提出物がないので他のことに集中！！"
            content.body = "この状態を維持するために、早めに行動しよう！"

            notificationDetail(
                uuid: String(UUID().uuidString),
                content: content,
                notificationRequest: notificationRequest
            )
        } else {
            for documentItem in documentItems {
                let content = UNMutableNotificationContent()
                content.sound = .default
                content.title = documentItem.documentTitle ?? ""
                let documentStatus = observeDocumentStatus(date: documentItem.deadLine ?? Date())
                if documentStatus != .none {
                    notificationSubtitle(status: documentStatus, content: content)
                    // 午前の通知
                    notificationDetail(
                        uuid: String(documentItem.uuidString),
                        content: content,
                        notificationRequest: notificationRequest
                    )
                }
            }
        }
    }

    func notificationSubtitle(status: DocumentStatus, content: UNMutableNotificationContent) {
        switch status {
        case .normal:
            content.subtitle = "締め切りは１週間以上あります"
            content.body = "早めに準備しておくことに越したことはないです"
        case .befor1Week:
            content.subtitle = "締め切りが１週間切りました"
            content.body = "もう，出せるとこまで準備したら出しましょう"
        case .befor3Day:
            content.subtitle = "締め切りはあと３日切りました"
            content.body = "直前になるよりは今、出しておいた方が気持ち楽だと思います"
        case .befor1Day:
            content.subtitle = "締め切りは明日です"
            content.body = "今すぐ出しにいきましょう！\n今日中に出せない場合は連絡を入れましょう"
        case .deadline:
            content.subtitle = "今日が締め切りです！"
            content.body = "今すぐ出そう！早く出そう！今日一番にやることは提出だ！"
        case .overdue:
            content.subtitle = "締め切りが過ぎてしまいました"
            content.body = "土下座しにいく準備をしましょう"
        case .none:
            content.subtitle = "近い提出物はありません"
            content.body = "今日も一日頑張りましょう！"
        }
    }

    func notificationDetail(
        uuid: String,
        content: UNMutableNotificationContent,
        notificationRequest: UNUserNotificationCenter
    ) {
        var morning = DateComponents()
        morning.hour = 8
        morning.minute = 0

        let morningTrigger = UNCalendarNotificationTrigger(dateMatching: morning, repeats: false)
        let morningRequest = UNNotificationRequest(
            identifier: uuid,
            content: content,
            trigger: morningTrigger
        )
        notificationRequest.add(morningRequest) { error in
            if let error = error {
                print(error.localizedDescription)
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
                observeDocumentCellObject()
                notification()
                tableView.reloadData()
                updateBadge()
            } else {
                return
            }
        }
        if editingStyle == .none {
        }
    }

    func diffDay(date: Date) -> Int {
        // ここは後でよく考える
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let nowDayString = formatter.string(from: now)
        let dateDayString = formatter.string(from: date)
        let nowDay = formatter.date(from: nowDayString)
        let dateDay = formatter.date(from: dateDayString)
        let calendar = Calendar(identifier: .gregorian)

        let diff = calendar.dateComponents([.day], from: nowDay ?? now, to: dateDay ?? now)
        let diffDay = Int(diff.day!)
        return diffDay
    }

    private func diffDate(date: Date) -> String {
        let diffDay = diffDay(date: date)
        if diffDay > 0 {
            return "締め切りまで \(diffDay) 日です"
        } else if diffDay == 0 {
            return "今日が提出期限です"
        } else {
            return "提出期限が過ぎています"
        }
    }

    private func observeDocumentStatus(date: Date) -> DocumentStatus {
        let diffDay = diffDay(date: date)
        if diffDay == 1 {
            if diffDay > 1 {
                if diffDay >= 3 {
                    if diffDay > 7 {
                        if diffDay > 14 {
                            return .none
                        }
                        return .normal
                    }
                    return .befor1Week
                }
                return .befor3Day
            }
            return .befor1Day

        } else if diffDay == 0 {
            return .deadline
        } else if diffDay < 0 {
            return .overdue
        } else {
            return .none
        }
    }
}

extension DocumentsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
