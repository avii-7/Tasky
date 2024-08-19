//
//  MockTaskRepository.swift
//  TaskyTests
//
//  Created by Arun on 16/08/24.
//

import Foundation
@testable import Tasky

class MockTaskRepository: TaskRepository {
    
    var taskItems = [TaskItem]()
    
    var throwError = false
     
    func add(task: TaskItem) -> Result<Void, TaskRepositoryError> {
        if taskItems.contains(where: { $0.id == task.id }) {
            return .failure(.localStorageError(cause: "mock error"))
        }
        else {
            taskItems.append(task)
            return .success(())
        }
    }
    
    func update(task: Tasky.TaskItem) -> Result<Void, TaskRepositoryError> {
        if let index = taskItems.firstIndex(where: { $0.id == task.id }) {
            taskItems[index] = task
            return .success(())
        }
        else {
            return .failure(.localStorageError(cause: "mock error"))
        }
    }
    
    func delete(using id: UUID) -> Result<Void, TaskRepositoryError> {
        if let index = taskItems.firstIndex(where: { $0.id == id }) {
            taskItems.remove(at: index)
            return .success(())
        }
        else {
            return .failure(.localStorageError(cause: "mock error"))
        }
    }
    
    func getAll(isCompleted: Bool) -> Result<[TaskItem], TaskRepositoryError> {
        
        if throwError {
            return .failure(.localStorageError(cause: "mock error"))
        }
        
        let taskItems = taskItems.filter { $0.isCompleted == isCompleted }
        return .success(taskItems)
    }
    
    func getTask(by id: UUID) -> Result<TaskItem?, Tasky.TaskRepositoryError> {
        if let index = taskItems.firstIndex(where: { $0.id == id }) {
            return .success(taskItems[index])
        }
        else {
            return .failure(.localStorageError(cause: "Task item not found"))
        }
    }
}
