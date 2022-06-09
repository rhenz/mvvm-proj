//
//  WeatherDayTableViewCell.swift
//  Cloudy
//
//

import UIKit

class WeatherDayTableViewCell: UITableViewCell {

    // MARK: - Properties

    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    // MARK: - Initialization

    override func awakeFromNib() {
        super.awakeFromNib()

        // Configure Cell
        selectionStyle = .none
    }
    
    // MARK: - Public API
    func configure(with presentable: WeekDayPresentable) {
        // Configure Icon Image View
        dayLabel.text = presentable.day
        dateLabel.text = presentable.date
        temperatureLabel.text = presentable.temperature
        windSpeedLabel.text = presentable.windSpeed
        iconImageView.image = UIImage.imageForIcon(with: presentable.image)?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = .systemMint
    }

}
