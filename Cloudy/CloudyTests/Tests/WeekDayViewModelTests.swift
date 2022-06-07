//
//  WeekDayViewModelTests.swift
//  CloudyTests
//
//  Created by John Salvador on 6/5/22.
//  Copyright © 2022 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class WeekDayViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: WeekDayViewModel!

    // MARK: - Set Up & Tear Down
    
    override func setUpWithError() throws {
        // Load Stub
        let data = loadStub(name: "weather", extension: "json")
        
        // Initialize JSONDecoder
        let decoder = JSONDecoder()
        
        // Configure JSONDecoder
        decoder.dateDecodingStrategy = .secondsSince1970
        
        // Decode Data
        let weatherData = try! decoder.decode(WeatherData.self, from: data)
        
        // Initialize View Model
        viewModel = WeekDayViewModel(weatherDayData: weatherData.dailyData[0])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        // Reset User Defaults
        UserDefaults.standard.removeObject(forKey: "unitsNotation")
        UserDefaults.standard.removeObject(forKey: "temperatureNotation")
    }

    // MARK: - Tests
    
    func test_day() {
        XCTAssertEqual(viewModel.day, "Monday")
    }
    
    func test_date() {
        XCTAssertEqual(viewModel.date, "June 22")
    }
    
    func testTemperature_Fahrenheit() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: "temperatureNotation")

        XCTAssertEqual(viewModel.temperature, "53 °F - 71 °F")
    }

    func testTemperature_Celsius() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: "temperatureNotation")

        XCTAssertEqual(viewModel.temperature, "12 °C - 22 °C")
    }

    func testWindSpeed_Imperial() {
        let unitsNotation: UnitsNotation = .imperial
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: "unitsNotation")

        XCTAssertEqual(viewModel.windSpeed, "6 MPH")
    }

    func testWindSpeed_Metric() {
        let unitsNotation: UnitsNotation = .metric
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: "unitsNotation")

        XCTAssertEqual(viewModel.windSpeed, "10 KPH")
    }

    func test_imageName() {
        XCTAssertEqual(viewModel.image, "partly-cloudy-day")
    }
}

/*
{
    "time": 1592776800,
    "summary": "Partly cloudy throughout the day.",
    "icon": "partly-cloudy-day",
    "sunriseTime": 1592789580,
    "sunsetTime": 1592856540,
    "moonPhase": 0.05,
    "precipIntensity": 0.0002,
    "precipIntensityMax": 0.0004,
    "precipIntensityMaxTime": 1592828400,
    "precipProbability": 0.05,
    "precipType": "rain",
    "temperatureHigh": 70.74,
    "temperatureHighTime": 1592822940,
    "temperatureLow": 55.06,
    "temperatureLowTime": 1592877180,
    "apparentTemperatureHigh": 70.24,
    "apparentTemperatureHighTime": 1592822940,
    "apparentTemperatureLow": 55.55,
    "apparentTemperatureLowTime": 1592877180,
    "dewPoint": 51.99,
    "humidity": 0.67,
    "pressure": 1018.2,
    "windSpeed": 6.32,
    "windGust": 17.62,
    "windGustTime": 1592782560,
    "windBearing": 112,
    "cloudCover": 0.32,
    "uvIndex": 6,
    "uvIndexTime": 1592821440,
    "visibility": 10,
    "ozone": 318.1,
    "temperatureMin": 53.43,
    "temperatureMinTime": 1592787840,
    "temperatureMax": 70.74,
    "temperatureMaxTime": 1592822940,
    "apparentTemperatureMin": 53.92,
    "apparentTemperatureMinTime": 1592787840,
    "apparentTemperatureMax": 70.24,
    "apparentTemperatureMaxTime": 1592822940
}
*/
