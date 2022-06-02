//
//  SettingsTemperatureViewModel.swift
//  Cloudy
//
//  Created by John Salvador on 5/31/22.
//

import Foundation

struct SettingsTemperatureViewModel {
    
    // MARK: - Properties
    
    let temperatureNotation: TemperatureNotation
    
    // MARK: - Public API
    var text: String {
        switch temperatureNotation {
        case .fahrenheit:
            return "Fahrenheit"
        case .celsius:
            return "Celcius"
        }
    }
    
    var shouldDisplayCheckmarkAccessory: Bool {
        return UserDefaults.temperatureNotation == temperatureNotation
    }
}

extension SettingsTemperatureViewModel: SettingsPresentable { }
