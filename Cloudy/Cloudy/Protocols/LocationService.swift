//
//  LocationService.swift
//  Cloudy
//
//  Created by John Salvador on 6/9/22.
//  Copyright © 2022 Cocoacasts. All rights reserved.
//

import Foundation

// MARK: - Types

enum LocationServiceError: Error {
    
    // MARK: - Cases
    
    case invalidAddressString
    case requestFailed(Error)
}

protocol LocationService {
    
    // MARK: - Type Aliases
    
    typealias Completion = (Result<[Location], LocationServiceError>) -> Void
    
    // MARK: - Methods
    
    func geocode(_ addressString: String, completion: @escaping Completion)
}
