//
//  TestCoreDataPersistence.swift
//  TaskyTests
//
//  Created by Arun on 19/08/24.
//

import Foundation
@testable import Tasky

class TestCoreDataPersistence: CoreDataPersistence {
    
    private override init(inMemory: Bool = false) {
        super.init(inMemory: true)
    }
    
    convenience init() {
        self.init(inMemory: true)
    }
}
