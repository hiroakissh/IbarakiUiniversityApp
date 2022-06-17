//
//  LabToDoTableViewCell.swift
//  IbarakiUiniversityApp
//
//  Created by HiroakiSaito on 2022/03/30.
//

import UIKit

class LabToDoTableViewCell: UITableViewCell {
    @IBOutlet private(set) weak var todoLabel: UILabel!
    @IBOutlet private(set) weak var todoContentView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        todoContentView.layer.cornerRadius = 20.0
        todoContentView.layer.shadowOffset = .init(width: 0.2, height: 0.2)
        todoContentView.layer.shadowOpacity = 0.3
        todoContentView.layer.shadowRadius = 10.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
