//
//  CoreDataTaskRepository.swift
//  Tasky
//
//  Created by Arun on 15/08/24.
//

import Foundation

final class CoreDataTaskRepository: TaskRepository {
    
    private let persistentController = PersistenceController.shared
    
    func add(task: TaskItem) -> Bool {
        let taskEntity = TaskEntity(context: persistentController.context)
        taskEntity.id = task.id
        taskEntity.name = task.name
        taskEntity.taskDescription = task.description
        taskEntity.isCompleted = task.isCompleted
        taskEntity.finishedDate = task.finishedDate
        
        return persistentController.saveContext()
    }
    
    func update(task: TaskItem) -> Bool {
        guard let taskEntity = getTask(by: task.id) else { return false }
        taskEntity.name = task.name
        taskEntity.taskDescription = task.description
        taskEntity.finishedDate = task.finishedDate
        taskEntity.isCompleted = task.isCompleted
        return persistentController.saveContext()
    }
    
    func delete(using id: UUID) -> Bool {
        guard let taskEntity = getTask(by: id) else { return false }
        persistentController.context.delete(taskEntity)
        return persistentController.saveContext()
    }
    
    func getAll(isCompleted: Bool) -> [TaskItem] {
        
        let request = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "isCompleted == %@", NSNumber(value: isCompleted))
        
        do {
            let result = try persistentController.context.fetch(request)
            return result.map { $0.convertToDomain() }
        }
        catch {
            debugPrint(error.localizedDescription)
        }
        return []
    }
    
    private func getTask(by id: UUID) -> TaskEntity? {
        let request = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1
        
        do {
            let result = try persistentController.context.fetch(request).first
            return result
        }
        catch {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
}
