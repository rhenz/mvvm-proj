//
//  DayViewViewModelTests.swift
//  CloudyTests
//
//  Created by John Salvador on 6/5/22.
//  Copyright © 2022 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class DayViewViewModelTests: XCTestCase {

    // MARK: - Properties
    
    var viewModel: DayViewModel!
    
    
    // MARK: - Set Up & Tear Down
    override func setUp() async throws {
        // Load Stub
        let data = loadStub(name: "weather", extension: "json")
        
        // Initialize JSONDecoder
        let jsonDecoder = JSONDecoder()
        
        // Configure JSONDecoder
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        
        // Decode Data
        let weatherData = try! jsonDecoder.decode(WeatherData.self, from: data)
        
        // Initialize View Model
        viewModel = DayViewModel(weatherData: weatherData)
    }
    
    override func tearDown() async throws {
        // Reset User Defaults
        UserDefaults.standard.removeObject(forKey: "timeNotation")
        UserDefaults.standard.removeObject(forKey: "unitsNotation")
        UserDefaults.standard.removeObject(forKey: "temperatureNotation")
    }
    
    
    // MARK: - Tests
    func test_date() {
        XCTAssertEqual(viewModel.date, "Mon, June 22")
    }
    
    func testTime_TwelveHour() {
        let timeNotation: TimeNotation = .twelveHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: "timeNotation")

        XCTAssertEqual(viewModel.time, "10:53 PM")
    }
    
    func testTime_TwentyFourHour() {
        let timeNotation: TimeNotation = .twentyFourHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: "timeNotation")

        XCTAssertEqual(viewModel.time, "22:53")
    }
    
    func testSummary() {
        XCTAssertEqual(viewModel.summary, "Overcast")
    }


    func testTemperature_Fahrenheit() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: "temperatureNotation")

        XCTAssertEqual(viewModel.temperature, "68.7 °F")
    }

    func testTemperature_Celsius() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: "temperatureNotation")

        XCTAssertEqual(viewModel.temperature, "20.4 °C")
    }

    func testWindSpeed_Imperial() {
        let unitsNotation: UnitsNotation = .imperial
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: "unitsNotation")

        XCTAssertEqual(viewModel.windSpeed, "6 MPH")
    }

    func testWindSpeed_Metric() {
        let unitsNotation: UnitsNotation = .metric
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: "unitsNotation")

        print(viewModel.windSpeed)

        XCTAssertEqual(viewModel.windSpeed, "10 KPH")
    }
    
    func test_image() {
        XCTAssertEqual(viewModel.image, "cloudy")
    }
}
