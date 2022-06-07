//
//  WeekViewModelTests.swift
//  CloudyTests
//
//  Created by John Salvador on 6/5/22.
//  Copyright © 2022 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class WeekViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: WeekViewModel!

    // MARK: - Set Up & Tear Down
    
    override func setUpWithError() throws {
        // Load Stub
        let data = loadStub(name: "weather", extension: "json")
        
        // Initialize JSONDecoder
        let decoder = JSONDecoder()
        
        // Configure Decoder
        decoder.dateDecodingStrategy = .secondsSince1970
        
        // Decode Data
        let weatherData = try! decoder.decode(WeatherData.self, from: data)
        
        // Initialize View Model
        viewModel = WeekViewModel(weatherData: weatherData.dailyData)
    }

    override func tearDownWithError() throws {
        
    }


    // MARK: - Tests
    
    func test_numberOfDays() {
        XCTAssertEqual(viewModel.numberOfDays, 8)
    }
    
    func test_initializeWeekDayViewModel() {
        let weatherDayViewModel = viewModel.viewModel(for: 5)
        
        XCTAssertEqual(weatherDayViewModel.day, "Saturday")
        XCTAssertEqual(weatherDayViewModel.date, "June 27")
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
