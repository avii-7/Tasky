//
//  CoreDataTaskRepository.swift
//  Tasky
//
//  Created by Arun on 15/08/24.
//

import Foundation

final class CoreDataTaskRepository: TaskRepository {
    
    private let persistence: CoreDataPersistence
    
    init(persistence: CoreDataPersistence) {
        self.persistence = persistence
    }
    
    func add(task: TaskItem) -> Result<Void, TaskRepositoryError> {
        do {
            let taskEntity = TaskEntity(context: persistence.context)
            taskEntity.id = task.id
            taskEntity.name = task.name
            taskEntity.taskDescription = task.description
            taskEntity.isCompleted = task.isCompleted
            taskEntity.finishedDate = task.finishedDate
            
            try persistence.saveContext()
            return .success(())
        }
        catch {
            return .failure(.localStorageError(cause: "error on add = \(error.localizedDescription)"))
        }
    }
    
    func update(task: TaskItem) -> Result<Void, TaskRepositoryError> {
        do {
            let taskEntityResult = getTaskEnity(by: task.id)

            switch taskEntityResult {
            case .success(let taskEntity):
                
                guard let taskEntity else {
                    return .failure(.localStorageError(cause: "Entity doesn't exist"))
                }
                
                taskEntity.name = task.name
                taskEntity.taskDescription = task.description
                taskEntity.finishedDate = task.finishedDate
                taskEntity.isCompleted = task.isCompleted
                
                try persistence.saveContext()
                return .success(())
                
            case .failure(let failure):
                return .failure(failure)
            }
        }
        catch {
            return
                .failure(.localStorageError(cause: "error on update = \(error.localizedDescription)"))
        }
    }
    
    func delete(using id: UUID) -> Result<Void, TaskRepositoryError> {
        do {
            let taskEntityResult = getTaskEnity(by: id)

            switch taskEntityResult {
            case .success(let taskEntity):
                
                guard let taskEntity else {
                    return .failure(.localStorageError(cause: "Entity doesn't exist"))
                }
                
                persistence.context.delete(taskEntity)
                
                try persistence.saveContext()
                return .success(())
                
            case .failure(let failure):
                return .failure(failure)
            }
        }
        catch {
            return .failure(.localStorageError(cause: "error on delete = \(error.localizedDescription)"))
        }
    }
    
    func getAll(isCompleted: Bool) -> Result<[TaskItem], TaskRepositoryError> {
        do {
            let request = TaskEntity.fetchRequest()
            request.predicate = NSPredicate(format: "isCompleted == %@", NSNumber(value: isCompleted))
            let entities = try persistence.context.fetch(request)
            let taskItems = entities.map { $0.convertToDomain() }
            return .success(taskItems)
        }
        catch {
            return .failure(.localStorageError(cause: "error on getAll(isCompleted:) = \(error.localizedDescription)"))
        }
    }
    
    func getTask(by id: UUID) -> Result<TaskItem?, TaskRepositoryError> {
        let result = getTaskEnity(by: id)
        
        switch result {
        case .success(let taskItem):
            return .success(taskItem?.convertToDomain())
        case .failure(let error):
            return .failure(.localStorageError(cause: error.localizedDescription))
        }
    }
    
    private func getTaskEnity(by id: UUID) -> Result<TaskEntity?, TaskRepositoryError> {
        do {
            let request = TaskEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            request.fetchLimit = 1
            
            let result = try persistence.context.fetch(request).first
            return .success(result)
        }
        catch {
            return .failure(.localStorageError(cause: "error on getTask(id:) = \(error.localizedDescription)"))
        }
    }
}
