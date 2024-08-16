//
//  TaskRepository.swift
//  Tasky
//
//  Created by Arun on 15/08/24.
//

import Foundation

protocol TaskRepository {
    
    func add(task: TaskItem) throws -> Bool
    
    func update(task: TaskItem) throws -> Bool
    
    func delete(using id: UUID) throws -> Bool
    
    func getAll(isCompleted: Bool) throws -> [TaskItem]
}
