//
//  WeekViewModel.swift
//  Cloudy
//
//  Created by John Salvador on 5/31/22.
//

import Foundation

struct WeekViewModel {
    
    // MARK: - Properties
    let weatherData: [WeatherDayData]
    
    // MARK: - Public API
    var numberOfSections: Int {
        1
    }
    
    var numberOfDays: Int {
        weatherData.count
    }
    
    func viewModel(for index: Int) -> WeekDayViewModel {
        return WeekDayViewModel(weatherDayData: weatherData[index])
    }
}
