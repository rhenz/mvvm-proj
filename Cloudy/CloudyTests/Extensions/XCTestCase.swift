//
//  XCTestCase.swift
//  CloudyTests
//
//  Created by John Salvador on 6/5/22.
//  Copyright © 2022 Cocoacasts. All rights reserved.
//

import XCTest

extension XCTest {
    
    // MARK: - Helper Methods
    
    func loadStub(name: String, extension: String) -> Data {
        // Obtain Reference to Bundle
        let bundle = Bundle(for: type(of: self))
        
        // Ask Bundle for URL of Stub
        let url = bundle.url(forResource: name, withExtension: `extension`)
        
        // Use URL to Create Data Object
        return try! Data(contentsOf: url!)
    }
}
