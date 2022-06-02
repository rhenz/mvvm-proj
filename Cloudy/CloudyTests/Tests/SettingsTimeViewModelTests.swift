//
//  SettingsTimeViewModelTests.swift
//  CloudyTests
//
//  Created by John Salvador on 6/2/22.
//  Copyright © 2022 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class SettingsTimeViewModelTests: XCTestCase {

    // MARK: - Set Up & Tear Down
    var currentTimeNotationRawValue: Int?
    
    override func setUpWithError() throws {
        currentTimeNotationRawValue = UserDefaults.timeNotation.rawValue
    }
    
    override func tearDownWithError() throws {
        // Reset User Defaults to Original Time Notation
        guard let currentTimeNotationRawValue = currentTimeNotationRawValue else {
            XCTFail("currentTimeNotationRawValue should not be nil")
            return
        }

        UserDefaults.timeNotation = TimeNotation(rawValue: currentTimeNotationRawValue)!
    }
    
    // MARK: - Tests for Text

    func test_TextTwelveHour() {
        let viewModel = SettingsTimeViewModel(timeNotation: .twelveHour)

        XCTAssertEqual(viewModel.text, "12 Hour")
    }
    
    func test_TextTwentyFourHour() {
        let viewModel = SettingsTimeViewModel(timeNotation: .twentyFourHour)

        XCTAssertEqual(viewModel.text, "24 Hour")
    }
    
    func test_accessoryTypeCheckmarkForTwelveHour() {
        let timeNotation: TimeNotation = .twelveHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: "timeNotation")
        
        let viewModel = SettingsTimeViewModel(timeNotation: .twelveHour)

        XCTAssertTrue(viewModel.shouldDisplayCheckmarkAccessory)
    }
    
    func test_accessoryTypeNoneForTwelveHour() {
        let timeNotation: TimeNotation = .twentyFourHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: "timeNotation")
        let viewModel = SettingsTimeViewModel(timeNotation: .twelveHour)
        XCTAssertFalse(viewModel.shouldDisplayCheckmarkAccessory)
    }
    
    func test_accessoryTypeCheckmarkForTwentyFourHour() {
        let timeNotation: TimeNotation = .twentyFourHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: "timeNotation")
        
        let viewModel = SettingsTimeViewModel(timeNotation: .twentyFourHour)

        XCTAssertTrue(viewModel.shouldDisplayCheckmarkAccessory)
    }
    
    func test_accessoryTypeNoneForTwentyFourHour() {
        let timeNotation: TimeNotation = .twelveHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: "timeNotation")
        
        let viewModel = SettingsTimeViewModel(timeNotation: .twentyFourHour)

        XCTAssertFalse(viewModel.shouldDisplayCheckmarkAccessory)
    }

}
