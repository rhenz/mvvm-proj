//
//  LocationTableViewCell.swift
//  Cloudy
//
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    // MARK: - Properties

    @IBOutlet var mainLabel: UILabel!

    // MARK: - Configuration

    func configure(withViewModel viewModel: LocationRepresentable) {
        // Configure Main Label
        mainLabel.text = viewModel.text
    }

}
