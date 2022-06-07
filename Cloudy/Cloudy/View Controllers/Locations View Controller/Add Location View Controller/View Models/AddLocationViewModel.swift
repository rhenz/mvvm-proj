//
//  AddLocationViewModel.swift
//  Cloudy
//
//  Created by John Salvador on 6/7/22.
//  Copyright © 2022 Cocoacasts. All rights reserved.
//

import Foundation
import CoreLocation
import Combine

class AddLocationViewModel {
    
    // MARK: - Properties
    
    @Published var query: String = ""
    
    // MARK: -
    
    @Published private(set) var querying = false
    
    // MARK: -
    
    private var locations: [Location] {
        get { locationsSubject.value }
        set { locationsSubject.value = newValue }
    }
    
    var locationsPublisher: AnyPublisher<[Location], Never> {
        locationsSubject.eraseToAnyPublisher()
    }
    
    private var locationsSubject = CurrentValueSubject<[Location], Never>([])
    
    var hasLocations: Bool {
        numberOfLocations > 0
    }
    
    var numberOfLocations: Int {
        locations.count
    }
    
    // MARK: -
    
    private lazy var geocoder = CLGeocoder()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Public API
    init() {
        // Setup Bindings
        setupBindings()
    }
    
    func location(at index: Int) -> Location? {
        guard index < locations.count else {
            return nil
        }
        
        return locations[index]
    }
    
    func viewModelForLocation(at index: Int) -> LocationRepresentable? {
        guard let location = location(at: index) else {
            return nil
        }

        return LocationViewModel(location: location.location, locationAsString: location.name)
    }
    
    // MARK: - Helper Methods
    private func setupBindings() {
        $query
            .removeDuplicates()
            .throttle(for: 0.5, scheduler: RunLoop.main, latest: true)
            .sink { [weak self] addressString in
                self?.geocode(addressString: addressString)
            }.store(in: &subscriptions)
    }
    
    private func geocode(addressString: String?) {
        guard let addressString = addressString else {
            // Reset location
            locations.removeAll()
            
            return
        }
        
        // Update helper
        querying = true
        
        // Geocode Address String
        geocoder.geocodeAddressString(addressString) { [weak self] placemarks, error in
            // Create Buffer
            var locations: [Location] = []
            
            // Update Helper
            self?.querying = false
            
            if let error = error {
                print("Unable to Forward Geocode Address \(error)")
            } else if let placemarks = placemarks {
                locations = placemarks.compactMap({ placemark in
                    guard let name = placemark.name else { return nil }
                    guard let location = placemark.location else { return nil }
                    return Location(name: name, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                })
            }
            
            // Update Locations
            self?.locations = locations
        }
    }
}
