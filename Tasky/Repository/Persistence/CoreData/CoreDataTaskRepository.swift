//
//  CoreDataTaskRepository.swift
//  Tasky
//
//  Created by Arun on 15/08/24.
//

import Foundation

final class CoreDataTaskRepository: TaskRepository {
    
    private let persistentController = CoreDataPersistence.shared
    
    func add(task: TaskItem) throws -> Bool {
        do {
            let taskEntity = TaskEntity(context: persistentController.context)
            taskEntity.id = task.id
            taskEntity.name = task.name
            taskEntity.taskDescription = task.description
            taskEntity.isCompleted = task.isCompleted
            taskEntity.finishedDate = task.finishedDate
            
            return try persistentController.saveContext()
        }
        catch {
            debugPrint("error on add = \(error.localizedDescription)")
            throw TaskRepositoryError.add
        }
    }
    
    func update(task: TaskItem) throws -> Bool {
        do {
            guard let taskEntity = try getTask(by: task.id) else { return false }
            taskEntity.name = task.name
            taskEntity.taskDescription = task.description
            taskEntity.finishedDate = task.finishedDate
            taskEntity.isCompleted = task.isCompleted
            return try persistentController.saveContext()
        }
        catch {
            debugPrint("error on update = \(error.localizedDescription)")
            throw TaskRepositoryError.update
        }
    }
    
    func delete(using id: UUID) throws -> Bool {
        guard let taskEntity = try getTask(by: id) else { return false }
        persistentController.context.delete(taskEntity)
        
        do {
            return try persistentController.saveContext()
        }
        catch {
            debugPrint("error on delete = \(error.localizedDescription)")
            throw TaskRepositoryError.delete
        }
    }
    
    func getAll(isCompleted: Bool) throws -> [TaskItem] {
        
        let request = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "isCompleted == %@", NSNumber(value: isCompleted))
        
        do {
            let result = try persistentController.context.fetch(request)
            return result.map { $0.convertToDomain() }
        }
        catch {
            debugPrint("error on getAll = \(error.localizedDescription)")
            throw TaskRepositoryError.get
        }
    }
    
    private func getTask(by id: UUID) throws -> TaskEntity? {
        let request = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1
        
        do {
            let result = try persistentController.context.fetch(request).first
            return result
        }
        catch {
            debugPrint("error on getTask(id:) = \(error.localizedDescription)")
            throw TaskRepositoryError.get
        }
    }
}
