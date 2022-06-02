//
//  LocationViewModel.swift
//  Cloudy
//
//

import CoreLocation

struct LocationViewModel {

    // MARK: - Properties

    let location: CLLocation?
    let locationAsString: String?

    // MARK: - Initialization

    init(location: CLLocation? = nil, locationAsString: String? = nil) {
        // Set Properties
        self.location = location
        self.locationAsString = locationAsString
    }

}

extension LocationViewModel: LocationRepresentable {

    var text: String {
        if let locationAsString = locationAsString {
            return locationAsString
        } else if let location = location {
            return location.asString
        }

        return "Unknown Location"
    }

}

extension CLLocation {

    var asString: String {
        let latitude = String(format: "%.3f", coordinate.latitude)
        let longitude = String(format: "%.3f", coordinate.longitude)
        return "\(latitude), \(longitude)"
    }

}
