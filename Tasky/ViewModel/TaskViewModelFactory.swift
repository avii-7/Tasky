//
//  TaskViewModelFactory.swift
//  Tasky
//
//  Created by Arun on 15/08/24.
//

import Foundation

final class TaskViewModelFactory {
    
    static func createTaskViewModel() -> TaskViewModel {
        let coreDataRepository = CoreDataTaskRepository()
        return TaskViewModel(taskRepository: coreDataRepository)
    }
}
