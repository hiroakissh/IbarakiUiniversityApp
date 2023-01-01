//
//  DocumentDetailViewController.swift.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2023/01/01.
//

import UIKit

class DocumentDetailViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    var detailDocument: (String, Date)? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        print(detailDocument)
        guard let detailDocument = detailDocument else { return }
        titleLabel.text = detailDocument.0

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateLabel.text = formatter.string(from: detailDocument.1)
    }
    @IBAction private func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
}
