//
//  showWebSiteViewController.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2022/06/24.
//

import UIKit
import WebKit
import SwiftUI

class ShowWebSiteViewController: UIViewController {
    @IBOutlet private weak var classTableView: UITableView!
    @IBOutlet private weak var homeTableView: UITableView!

    private let classSite = ["ポータルサイト", "manaba"]
    private let homeSite = ["全学部共通", "工学部", "理学部", "農学部", "人文社会学部", "教育学部"]

    private let classSiteURL = ["https://idc.ibaraki.ac.jp/portal/",
                                "https://manaba.ibaraki.ac.jp/"]
    private let homeSiteURL = ["https://www.ibaraki.ac.jp/",
                               "https://www.eng.ibaraki.ac.jp/",
                               "https://www.sci.ibaraki.ac.jp/",
                               "https://www.agr.ibaraki.ac.jp/",
                               "http://www.hum.ibaraki.ac.jp/",
                               "http://www.edu.ibaraki.ac.jp/"]

    override func viewDidLoad() {
        super.viewDidLoad()

        classTableView.delegate = self
        classTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.dataSource = self

        settingUI()
    }

    func settingUI() {
        classTableView.layer.cornerRadius = 10
        homeTableView.layer.cornerRadius = 10
    }
}

extension ShowWebSiteViewController {
    private func moveSite(_ index: Int, _ tableViewName: String) {
        if tableViewName == "class" {
            let url = NSURL(string: classSiteURL[index])
            // TODO: 後で強制キャストを直す
            UIApplication.shared.open(url! as URL, completionHandler: nil)
        } else if tableViewName == "home" {
            let url = NSURL(string: homeSiteURL[index])
            UIApplication.shared.open(url! as URL, completionHandler: nil)
        } else {
            fatalError()
        }
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
        if classTableView == tableView {
            moveSite(indexPath.row, "class")
        } else if homeTableView == tableView {
            moveSite(indexPath.row, "home")
        } else {
            print("tableViewが正常に読み込まれていません")
            fatalError()
        }
    }
}
