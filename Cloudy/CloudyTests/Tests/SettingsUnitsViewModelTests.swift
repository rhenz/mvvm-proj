//
//  SettingsUnitsViewModelTests.swift
//  CloudyTests
//
//  Created by John Salvador on 6/2/22.
//  Copyright © 2022 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class SettingsUnitsViewModelTests: XCTestCase {

    // MARK: - Set Up & Tear Down
    var currentUnitNotationRawValue: Int?
    
    override func setUpWithError() throws {
        currentUnitNotationRawValue = UserDefaults.unitsNotation.rawValue
    }
    
    override func tearDownWithError() throws {
        // Reset User Defaults to Original Time Notation
        guard let currentUnitNotationRawValue = currentUnitNotationRawValue else {
            XCTFail("currentTimeNotationRawValue should not be nil")
            return
        }

        UserDefaults.unitsNotation = UnitsNotation(rawValue: currentUnitNotationRawValue)!
    }
    
    // MARK: - Tests for Text

    func test_TextMetric() {
        let viewModel = SettingsUnitsViewModel(unitsNotation: .metric)
        XCTAssertEqual(viewModel.text, "Metric")
    }
    
    func test_TextImperial() {
        let viewModel = SettingsUnitsViewModel(unitsNotation: .imperial)
        XCTAssertEqual(viewModel.text, "Imperial")
    }
    
    func test_accessoryTypeCheckmarkForMetric() {
        let unitsNotation: UnitsNotation = .metric
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: "unitsNotation")
        let viewModel = SettingsUnitsViewModel(unitsNotation: .metric)
        XCTAssertTrue(viewModel.shouldDisplayCheckmarkAccessory)
    }
    
    func test_accessoryTypeNoneForMetric() {
        let unitsNotation: UnitsNotation = .imperial
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: "unitsNotation")
        let viewModel = SettingsUnitsViewModel(unitsNotation: .metric)
        XCTAssertFalse(viewModel.shouldDisplayCheckmarkAccessory)
    }
    
    func test_accessoryTypeCheckmarkForImperial() {
        let unitsNotation: UnitsNotation = .imperial
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: "unitsNotation")
        let viewModel = SettingsUnitsViewModel(unitsNotation: .imperial)
        XCTAssertTrue(viewModel.shouldDisplayCheckmarkAccessory)
    }
    
    func test_accessoryTypeNoneForImperial() {
        let unitsNotation: UnitsNotation = .metric
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: "unitsNotation")
        let viewModel = SettingsUnitsViewModel(unitsNotation: .imperial)
        XCTAssertFalse(viewModel.shouldDisplayCheckmarkAccessory)
    }

}
