//
//  Geocoder.swift
//  Cloudy
//
//  Created by John Salvador on 6/9/22.
//  Copyright © 2022 Cocoacasts. All rights reserved.
//

import Foundation
import CoreLocation

class Geocoder: LocationService {
    
    // MARK: - Properties
    
    private lazy var geocoder = CLGeocoder()
    
    
    // MARK: - Location Service
    
    func geocode(_ addressString: String, completion: @escaping Completion) {
        guard !addressString.isEmpty else {
            completion(.failure(.invalidAddressString))
            return
        }
        
        // Geocode Address String
        geocoder.geocodeAddressString(addressString) { placemarks, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
            } else if let placemarks = placemarks {
                // Create Locations
                let locations = placemarks.compactMap({ (placemark) -> Location? in
                    guard let name = placemark.name else { return nil }
                    guard let location = placemark.location else { return nil }
                    return Location(name: name, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                })
                
                completion(.success(locations))
            }
        }
    }
}
