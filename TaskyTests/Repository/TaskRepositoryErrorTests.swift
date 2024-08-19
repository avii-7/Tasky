//
//  TaskRepositoryErrorTests.swift
//  TaskyTests
//
//  Created by Arun on 19/08/24.
//

import XCTest
@testable import Tasky

final class TaskRepositoryErrorTests: XCTestCase {
    
    func testTaskRepositoryError() {
        let description = "testing error"
        let error = TaskRepositoryError.localStorageError(cause: description)
        
        XCTAssertEqual(error.errorDescription, description)
    }
}
