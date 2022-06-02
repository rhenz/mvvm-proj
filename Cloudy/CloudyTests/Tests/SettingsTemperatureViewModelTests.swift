//
//  SettingsTemperatureViewModelTests.swift
//  CloudyTests
//
//  Created by John Salvador on 6/2/22.
//  Copyright © 2022 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class SettingsTemperatureViewModelTests: XCTestCase {

    // MARK: - Set Up & Tear Down
    var currentTemperatureNotationRawValue: Int?
    
    override func setUpWithError() throws {
        currentTemperatureNotationRawValue = UserDefaults.temperatureNotation.rawValue
    }
    
    override func tearDownWithError() throws {
        // Reset User Defaults to Original Time Notation
        guard let currentTemperatureNotationRawValue = currentTemperatureNotationRawValue else {
            XCTFail("currentTemperatureNotationRawValue should not be nil")
            return
        }

        UserDefaults.temperatureNotation = TemperatureNotation(rawValue: currentTemperatureNotationRawValue)!
    }
    
    // MARK: - Tests for Text

    func test_TextCelcius() {
        let viewModel = SettingsTemperatureViewModel(temperatureNotation: .celsius)
        XCTAssertEqual(viewModel.text, "Celcius")
    }
    
    func test_TextFahrenhei() {
        let viewModel = SettingsTemperatureViewModel(temperatureNotation: .fahrenheit)
        XCTAssertEqual(viewModel.text, "Fahrenheit")
    }
    
    func test_accessoryTypeCheckmarkForCelcius() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: "temperatureNotation")
        let viewModel = SettingsTemperatureViewModel(temperatureNotation: .celsius)
        XCTAssertTrue(viewModel.shouldDisplayCheckmarkAccessory)
    }
    
    func test_accessoryTypeNoneForCelcius() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: "temperatureNotation")
        let viewModel = SettingsTemperatureViewModel(temperatureNotation: .celsius)
        XCTAssertFalse(viewModel.shouldDisplayCheckmarkAccessory)
    }
    
    func test_accessoryTypeCheckmarkForFahrenheit() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: "temperatureNotation")
        let viewModel = SettingsTemperatureViewModel(temperatureNotation: .fahrenheit)
        XCTAssertTrue(viewModel.shouldDisplayCheckmarkAccessory)
    }
    
    func test_accessoryTypeNoneForFahrenheit() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: "temperatureNotation")
        let viewModel = SettingsTemperatureViewModel(temperatureNotation: .fahrenheit)
        XCTAssertFalse(viewModel.shouldDisplayCheckmarkAccessory)
    }

}
