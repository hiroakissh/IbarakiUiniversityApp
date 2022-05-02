//
//  PortalViewController.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2021/10/01.
//

import UIKit
import WebKit

class PortalViewController: UIViewController {
    @IBOutlet private weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "https://idc.ibaraki.ac.jp/portal/") {
            self.webView.load(URLRequest(url: url))
            self.webView.allowsBackForwardNavigationGestures = true
        }
    }

    @IBAction private func reloadButton(_ sender: Any) {
        webView.reload()
    }
}
