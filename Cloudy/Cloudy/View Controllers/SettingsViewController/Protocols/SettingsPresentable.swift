//
//  SettingsPresentable.swift
//  Cloudy
//
//  Created by John Salvador on 5/31/22.
//

import Foundation

protocol SettingsPresentable {
    
    // MARK: - Properties
    
    var text: String { get }
    var shouldDisplayCheckmarkAccessory: Bool { get }
}
