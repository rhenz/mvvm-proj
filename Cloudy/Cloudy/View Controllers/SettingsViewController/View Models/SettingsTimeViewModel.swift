//
//  SettingsTimeViewModel.swift
//  Cloudy
//
//  Created by John Salvador on 5/31/22.
//

import Foundation

struct SettingsTimeViewModel {
    
    // MARK: - Properties
    
    let timeNotation: TimeNotation
    
    // MARK: - Public API
    
    var text: String {
        switch timeNotation {
        case .twelveHour:
            return "12 Hour"
        case .twentyFourHour:
            return "24 Hour"
        }
    }
    
    var shouldDisplayCheckmarkAccessory: Bool {
        return UserDefaults.timeNotation == timeNotation
    }
}

extension SettingsTimeViewModel: SettingsPresentable { }
