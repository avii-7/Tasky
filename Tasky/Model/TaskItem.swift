//
//  TaskItem.swift
//  Tasky
//
//  Created by Arun on 06/08/24.
//

import Foundation

struct TaskItem {
    let id: UUID
    var name: String
    var description: String
    var isCompleted: Bool
    var finishedDate: Date
}

extension TaskItem {
    
    static func createEmptyTask() -> TaskItem {
        return TaskItem(
            id: UUID(),
            name: "",
            description: "",
            isCompleted: false,
            finishedDate: Date.now
        )
    }
}
