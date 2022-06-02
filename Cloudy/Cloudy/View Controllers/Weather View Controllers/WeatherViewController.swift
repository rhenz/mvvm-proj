//
//  WeatherViewController.swift
//  Cloudy
//
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var weatherDataContainerView: UIView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Public Interface

    func reloadData() {}

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup View
        setupView()
    }

    // MARK: - View Methods

    private func setupView() {
        // Configure Message Label
        messageLabel.isHidden = true

        // Configure Weather Data Container View
        weatherDataContainerView.isHidden = true

        // Configure Activity Indicator View
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
    }

    // MARK: - Helper Methods

    func imageForIcon(withName name: String) -> UIImage? {
        switch name {
        case "clear-day":
            return UIImage(named: "clear-day")
        case "clear-night":
            return UIImage(named: "clear-night")
        case "rain":
            return UIImage(named: "rain")
        case "snow":
            return UIImage(named: "snow")
        case "sleet":
            return UIImage(named: "sleet")
        case "wind", "cloudy", "partly-cloudy-day", "partly-cloudy-night":
            return UIImage(named: "cloudy")
        default:
            return UIImage(named: "clear-day")
        }
    }

}
