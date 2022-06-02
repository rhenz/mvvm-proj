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
    
    // MARK: - Public API
    
    func configure(with presentable: SettingsPresentable) {
        // Configure Main Label
        mainLabel.text = presentable.text
        
        // Set Accessory Type
        accessoryType = presentable.shouldDisplayCheckmarkAccessory ? .checkmark : .none
    }

}
