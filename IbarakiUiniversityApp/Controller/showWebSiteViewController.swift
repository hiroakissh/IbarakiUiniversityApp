//
//  showWebSiteViewController.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2022/06/24.
//

import UIKit

enum SiteType {
    case classes
    case home
}

class ShowWebSiteViewController: UIViewController {
    @IBOutlet private weak var classTableView: UITableView!
    @IBOutlet private weak var homeTableView: UITableView!

    private let classSite = ["ポータルサイト", "manaba"]
    private let homeSite = ["全学部共通", "工学部", "理学部", "農学部", "人文社会学部", "教育学部"]

    override func viewDidLoad() {
        super.viewDidLoad()

        classTableView.delegate = self
        classTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.dataSource = self
    }
}

extension ShowWebSiteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if classTableView == tableView {
            return classSite.count
        } else if homeTableView == tableView {
            return homeSite.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if classTableView == tableView {
            let classCell = classTableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath)
            classCell.textLabel?.text = classSite[indexPath.row]
            return classCell
        } else if homeTableView == tableView {
            let homeSiteCell = homeTableView.dequeueReusableCell(withIdentifier: "homeSiteCell", for: indexPath)
            homeSiteCell.textLabel?.text = homeSite[indexPath.row]
            return homeSiteCell
        } else {
            let cell = classTableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath)
            cell.textLabel?.text = "読み込めていません"
            return cell
        }
    }
}

extension ShowWebSiteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
