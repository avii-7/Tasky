//
//  CoreDataTaskRepositoryTests.swift
//  TaskyTests
//
//  Created by Arun on 19/08/24.
//

import XCTest
@testable import Tasky
import CoreData

final class CoreDataTaskRepositoryTests: XCTestCase {
    
    private var coreDataTaskRepository: CoreDataTaskRepository!
    
    private var persistence: TestCoreDataPersistence!
    
    override func setUp() {
        persistence = TestCoreDataPersistence()
        coreDataTaskRepository = CoreDataTaskRepository(persistence: persistence)
    }
    
    override func tearDown() {
        coreDataTaskRepository = nil
        persistence = nil
    }
    
    func testAdd_Success() {
        var taskItem = TaskItem.empty()
        taskItem.name = "mock name"
        taskItem.description = "mock description"
        
        let result = coreDataTaskRepository.add(task: taskItem)
        
        if case .failure = result {
            XCTFail("Expected success")
        }
    }
    
    func testAdd_Faliure() {
        var taskItem = TaskItem.empty()
        taskItem.name = "mock name"
        taskItem.description = "mock description"
        
        _ = coreDataTaskRepository.add(task: taskItem)
        let result = coreDataTaskRepository.add(task: taskItem)
        
        if case .success = result {
            XCTFail("Expected Faliure")
        }
    }
    
    func testUpdate_Success() {
        var taskItem = TaskItem.empty()
        _ = coreDataTaskRepository.add(task: taskItem)
        
        let name = "Title mock"
        let description = "Description mock"
        let date = Date.now
        let isCompleted = true
        
        taskItem.name = name
        taskItem.description = description
        taskItem.finishedDate = date
        taskItem.isCompleted = isCompleted
        
        let result = coreDataTaskRepository.update(task: taskItem)
        
        if case .failure = result {
            XCTFail("Expected Success")
        }
        
        let updatedTaskResult = coreDataTaskRepository.getTask(by: taskItem.id)
        
        switch updatedTaskResult {
        case .success(let task):
            if let task {
                XCTAssertEqual(task.name, name)
                XCTAssertEqual(task.description, description)
                XCTAssertEqual(task.finishedDate, date)
                XCTAssertEqual(task.isCompleted, isCompleted)
            }
            else {
                XCTFail("Expected task")
            }
            
        case .failure:
            XCTFail("Expected success")
        }
    }
    
    func testUpdate_EntityDoesNotExistFailure() {
        let taskItem = TaskItem.empty()
        let result = coreDataTaskRepository.update(task: taskItem)
        
        switch result {
        case .success:
            XCTFail("Expected faliure.")
        case .failure(let failure):
            XCTAssertEqual(failure, TaskRepositoryError.localStorageError(cause: "Entity doesn't exist"))
        }
    }
    
    func testDelete_Success() {
        let taskItem = TaskItem.empty()
        _ = coreDataTaskRepository.add(task: taskItem)
        
        let deleteResult = coreDataTaskRepository.delete(using: taskItem.id)
        
        if case .failure = deleteResult {
            XCTFail("Expected Success")
        }
        
        let taskItemResult = coreDataTaskRepository.getTask(by: taskItem.id)
        
        switch taskItemResult {
        case .success(let taskItem):
            if taskItem != nil {
                XCTFail("Task item should not exist")
            }
        case .failure:
            XCTFail("Expected success with nil taskItem")
        }
    }
    
    func testDelete_EntityDoesNotExistFailure() {
        let taskItem = TaskItem.empty()
        let result = coreDataTaskRepository.delete(using: taskItem.id)
        
        if case .success = result {
            XCTFail("Expected faliure, Entity should not be exists")
        }
    }
}
