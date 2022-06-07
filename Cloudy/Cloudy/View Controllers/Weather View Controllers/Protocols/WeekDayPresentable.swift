//
//  WeatherDayPresentable.swift
//  Cloudy
//
//  Created by John Salvador on 6/2/22.
//  Copyright © 2022 Cocoacasts. All rights reserved.
//

import Foundation

protocol WeekDayPresentable {
    
    // MARK: - Properties
    
    var day: String { get }
    var date: String { get }
    var image: String { get }
    var windSpeed: String { get }
    var temperature: String { get }
}
