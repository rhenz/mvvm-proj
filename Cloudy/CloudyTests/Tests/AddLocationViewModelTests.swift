//
//  AddLocationViewModelTests.swift
//  CloudyTests
//
//  Created by John Salvador on 6/9/22.
//  Copyright © 2022 Cocoacasts. All rights reserved.
//

import XCTest
import Combine
@testable import Cloudy

class AddLocationViewModelTests: XCTestCase {
    
    // MARK: - Types
    private class MockLocationService: LocationService {
        func geocode(_ addressString: String, completion: @escaping Completion) {
            if addressString.isEmpty {
                // Invoke Completion Handler
                completion(.success([]))
            } else {
                // Invoke Completion Handler
                completion(.success([.brussels]))
            }
        }
    }
    
    // MARK: - Properties
    
    var viewModel: AddLocationViewModel!
    
    // MARK: -
    
    var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Set Up & Tear Down
    override func setUpWithError() throws {
        // Initialize Location Service
        let locationService = MockLocationService()
        
        // Initialize View Model
        viewModel = AddLocationViewModel(locationService: locationService)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Tests for Locations Publisher
    func test_locationsPublisher_hasLocations() {
        // Define Expectation
        let expectation = self.expectation(description: "Has Locations")
        
        // Define Expected Values
        let expectedValues: [[Location]] = [
            [],
            [.brussels]
        ]
        
        // Subscribe to Locations Publisher
        viewModel.locationsPublisher
            .collect(2)
            .sink { result in
                if result == expectedValues {
                    expectation.fulfill()
                }
            }.store(in: &subscriptions)
        
        // Set Query
        viewModel.query = "Brus"
        
        // Wait for Expectations
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_locationsPublisher_noLocations() {
        // Define Expectation
        let expectation = self.expectation(description: "No Locations")
        
        // Define Expected Values
        let expectedValues: [[Location]] = [
            [],
            []
        ]
        
        // Subscribe to Locations Publisher
        viewModel.locationsPublisher
            .collect(2)
            .sink { (result) in
                if result == expectedValues {
                    expectation.fulfill()
                }
            }.store(in: &subscriptions)
        
        // Set Query
        viewModel.query = ""
        
        // Wait for Expectations
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_locationAtIndex_notNil() {
        // Define Expectation
        let expectation = self.expectation(description: "Location Not Nil")
        
        // Attach Subscriber
        viewModel.locationsPublisher
            .collect(2)
            .sink { [weak self] _ in
                if let location = self?.viewModel.location(at: 0), location.name == Location.brussels.name {
                    expectation.fulfill()
                }
            }.store(in: &subscriptions)
        
        // Set Query
        viewModel.query = "Brus"
        
        // Wait for Expectations
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_locationAtIndex_nil() {
        // Define Expectation
        let expectation = self.expectation(description: "Location Nil")

        // Attach Subscriber
        viewModel.locationsPublisher
            .collect(2)
            .sink { [weak self] _ in
                if self?.viewModel.location(at: 0) == nil {
                    expectation.fulfill()
                }
            }.store(in: &subscriptions)

        // Set Query
        viewModel.query = ""

        // Wait for Expectations
        wait(for: [expectation], timeout: 1.0)
    }
}

// MARK: -

fileprivate extension Location {
    static var brussels: Location {
        Location(name: "Brussels", latitude: 50.8303, longitude: 4.3517)
    }
}
