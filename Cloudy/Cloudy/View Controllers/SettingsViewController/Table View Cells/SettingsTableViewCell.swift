//
//  SettingsTableViewCell.swift
//  Cloudy
//
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    // MARK: - Properties

    @IBOutlet var mainLabel: UILabel!

    // MARK: - Initialization

    override func awakeFromNib() {
        super.awakeFromNib()

        // Configure Cell
        selectionStyle = .none
    }

}
