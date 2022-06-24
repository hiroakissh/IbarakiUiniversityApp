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
        if (classTableView != nil) {
            return classSite.count
        } else if (homeTableView != nil) {
            return homeSite.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SiteCell", for: indexPath)
        return cell
    }
}

extension ShowWebSiteViewController: UITableViewDelegate {
}
