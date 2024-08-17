//
//  TaskViewModelTests.swift
//  TaskyTests
//
//  Created by Arun on 17/08/24.
//

import XCTest
@testable import Tasky

final class TaskViewModelTests: XCTestCase {

    private var sut: TaskViewModel!
    
    private var mockTaskRepository: MockTaskRepository!
    
    override func setUp() {
        mockTaskRepository = MockTaskRepository()
        sut = TaskViewModel(taskRepository: mockTaskRepository)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testInitialState() {
        XCTAssertTrue(sut.taskItems.isEmpty)
        XCTAssertFalse(sut.showErrorAlert)
        XCTAssertNil(sut.repositoryError)
    }
    
    func testShowTasksCompleted() {
        var completedTaskItem1 = TaskItem.empty()
        completedTaskItem1.isCompleted = true
        
        var completedTaskItem2 = TaskItem.empty()
        completedTaskItem2.isCompleted = true
        
        var inCompletedTaskItem = TaskItem.empty()
        inCompletedTaskItem.isCompleted = false
        
        mockTaskRepository.taskItems = [completedTaskItem1, completedTaskItem2, inCompletedTaskItem]
        
        sut.showTasks(isCompleted: true)
        XCTAssertEqual(sut.taskItems.count, 2)
        
        XCTAssertFalse(sut.showErrorAlert)
        XCTAssertNil(sut.repositoryError)
    }
    
    func testShowTasksIncompleted() {
        var completedTaskItem1 = TaskItem.empty()
        completedTaskItem1.isCompleted = true
        
        var notCompletedTaskItem = TaskItem.empty()
        notCompletedTaskItem.isCompleted = false
        
        mockTaskRepository.taskItems = [completedTaskItem1, notCompletedTaskItem]
        
        sut.showTasks(isCompleted: false)
        XCTAssertEqual(sut.taskItems.count, 1)
        
        XCTAssertFalse(sut.showErrorAlert)
        XCTAssertNil(sut.repositoryError)
    }
    
    func testShowTasks_Failure() {
        mockTaskRepository.throwError = true
        
        sut.showTasks(isCompleted: true)
        
        XCTAssertTrue(sut.showErrorAlert)
        XCTAssertNotNil(sut.repositoryError)
    }
    
    func testAddTask_Success() {
        let result = sut.addTask(TaskItem.empty())
        XCTAssertTrue(result, "Excepted true")
        
        XCTAssertFalse(sut.showErrorAlert)
        XCTAssertNil(sut.repositoryError)
    }
    
    func testAddTask_Failure() {
        let taskItem = TaskItem.empty()
        mockTaskRepository.taskItems = [taskItem]
        
        let result = sut.addTask(taskItem)
        XCTAssertFalse(result, "Excepted false")
    
        XCTAssertTrue(sut.showErrorAlert)
        XCTAssertNotNil(sut.repositoryError)
    }
    
    func testUpdateTask_Success() {
        let taskItem = TaskItem.empty()
        mockTaskRepository.taskItems = [taskItem]
        
        let result = sut.updateTask(taskItem)
        XCTAssertTrue(result, "Excepted true")
        
        XCTAssertFalse(sut.showErrorAlert)
        XCTAssertNil(sut.repositoryError)
    }
    
    func testUpdateTask_Failure() {
        let result = sut.updateTask(TaskItem.empty())
        XCTAssertFalse(result, "Excepted false")
    
        XCTAssertTrue(sut.showErrorAlert)
        XCTAssertNotNil(sut.repositoryError)
    }
    
    func testDeleteTask_Success() {
        let taskItem = TaskItem.empty()
        mockTaskRepository.taskItems = [taskItem]
        
        let result = sut.deleteTask(taskItem)
        XCTAssertTrue(result, "Excepted true")
        
        XCTAssertFalse(sut.showErrorAlert)
        XCTAssertNil(sut.repositoryError)
    }
    
    func testDeleteTask_Failure() {
        let result = sut.deleteTask(TaskItem.empty())
        XCTAssertFalse(result, "Excepted false")
    
        XCTAssertTrue(sut.showErrorAlert)
        XCTAssertNotNil(sut.repositoryError)
    }
}
