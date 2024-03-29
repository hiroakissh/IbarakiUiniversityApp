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

    var detailDocument: DocumentTransitionModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(detailDocument)
        guard let detailDocument = detailDocument else { return }
        titleLabel.text = detailDocument.title

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateLabel.text = formatter.string(from: detailDocument.deadLine)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditDocument" {
            let editDocumentVC = segue.destination as? EditDocumentViewController
            editDocumentVC?.editDocumentUUID = sender as? String
        }
    }
    @IBAction private func editButton(_ sender: Any) {
        performSegue(withIdentifier: "EditDocument", sender: detailDocument?.uuid)
    }
}
