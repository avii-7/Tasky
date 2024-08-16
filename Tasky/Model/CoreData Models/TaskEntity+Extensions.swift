//
//  TaskEntity+Extensions.swift
//  Tasky
//
//  Created by Arun on 15/08/24.
//

import Foundation

extension TaskEntity {
    
    func convertToDomain() -> TaskItem {
        TaskItem(
            id: self.id,
            name: self.name ?? "",
            description: self.taskDescription ?? "",
            isCompleted: self.isCompleted,
            finishedDate: self.finishedDate ?? Date()
        )
    }
}
