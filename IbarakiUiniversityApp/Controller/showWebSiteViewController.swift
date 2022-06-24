//
//  showWebSiteViewController.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2022/06/24.
//

import UIKit

class showWebSiteViewController: UIViewController {

    @IBOutlet private weak var classTableView: UITableView!
    @IBOutlet private weak var homeTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()

        classTableView.delegate = self
        classTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.dataSource = self

    }
}

extension showWebSiteViewController: UITableViewDelegate {

}

extension showWebSiteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }


}
