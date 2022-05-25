//
//  PortalViewController.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2021/10/01.
//

import UIKit
import WebKit

class PortalViewController: UIViewController {
    @IBOutlet private weak var moveButton: UIButton!

    var moveEnable: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        presentAlert()
        move()
    }
    private func move() {
        if moveEnable {
            let url = NSURL(string: "https://idc.ibaraki.ac.jp/portal/")
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        } else {
            return
        }
    }

    private func presentAlert() {
        let alert = UIAlertController(
            title: "注意", message: "外部のWebサイトに飛びます。開いても大丈夫でしょうか？", preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "はい",
            style: .default,
            handler: { _ in
                self.okEnableAction()
            }
        )
        let cancelAction = UIAlertAction(
            title: "いいえ",
            style: .cancel,
            handler: { _ in
                self.cancelEnableAction()
            }
        )
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    private func cancelEnableAction() {
        moveEnable = false
        moveButton.isEnabled = false
    }
    private func okEnableAction() {
        moveEnable = true
        moveButton.isEnabled = true
    }
    @IBAction private func loadButton(_ sender: Any) {
        move()
    }
    @IBAction private func permissionAction(_ sender: Any) {
        presentAlert()
    }
}
