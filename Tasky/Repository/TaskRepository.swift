//
//  TaskRepository.swift
//  Tasky
//
//  Created by Arun on 15/08/24.
//

import Foundation

protocol TaskRepository {
    
    func add(task: TaskItem) -> Bool
    
    func update(task: TaskItem) -> Bool
    
    func delete(using id: UUID) -> Bool
    
    func getAll(isCompleted: Bool) -> [TaskItem]
}
