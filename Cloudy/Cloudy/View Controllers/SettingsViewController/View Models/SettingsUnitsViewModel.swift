//
//  SettingsUnitsViewModel.swift
//  Cloudy
//
//  Created by John Salvador on 5/31/22.
//

import Foundation

struct SettingsUnitsViewModel {
    
    // MARK: - Properties
    
    let unitsNotation: UnitsNotation
    
    // MARK: - Public API
    var text: String {
        switch unitsNotation {
        case .imperial:
            return "Imperial"
        case .metric:
            return "Metric"
        }
    }
    
    var shouldDisplayCheckmarkAccessory: Bool {
        return UserDefaults.unitsNotation == unitsNotation
    }
}

extension SettingsUnitsViewModel: SettingsPresentable { }
