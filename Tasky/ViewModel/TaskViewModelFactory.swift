//
//  TaskViewModelFactory.swift
//  Tasky
//
//  Created by Arun on 15/08/24.
//

import Foundation

final class TaskViewModelFactory {
    
    static func createTaskViewModel() -> TaskViewModel {
        let persistence = CoreDataPersistence()
        let coreDataRepository = CoreDataTaskRepository(persistence: persistence)
        return TaskViewModel(taskRepository: coreDataRepository)
    }
}
