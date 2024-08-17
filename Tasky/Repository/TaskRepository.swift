//
//  TaskRepository.swift
//  Tasky
//
//  Created by Arun on 15/08/24.
//

import Foundation

protocol TaskRepository {
    
    func add(task: TaskItem) -> Result<Void, TaskRepositoryError>
    
    func update(task: TaskItem) -> Result<Void, TaskRepositoryError>
    
    func delete(using id: UUID) -> Result<Void, TaskRepositoryError>
    
    func getAll(isCompleted: Bool) -> Result<[TaskItem], TaskRepositoryError>
}
