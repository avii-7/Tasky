//
//  TaskViewModel.swift
//  Tasky
//
//  Created by Arun on 06/08/24.
//

import Foundation

class TaskViewModel : ObservableObject {
    
    @Published var taskItems = [TaskItem]()
    
    @Published var showErrorAlert = false
    
    var repositoryError: TaskRepositoryError?
    
    private var taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    let pickerDateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        
        let requiredComponents: Set<Calendar.Component> = [.day, .month, .year, .hour, .minute]
        let startComponents = calendar.dateComponents(requiredComponents, from: Date())
        let endComponents = calendar.dateComponents(requiredComponents, from: .distantFuture)
        
        return calendar.date(from:startComponents)!...calendar.date(from:endComponents)!
    }()
    
    func showTasks(isCompleted: Bool) {
        do {
            taskItems = try taskRepository.getAll(isCompleted: isCompleted)
        }
        catch {
            repositoryError = error as? TaskRepositoryError
            showErrorAlert = true
        }
    }
    
    func addTask(_ task: TaskItem) -> Bool {
        do {
            return try taskRepository.add(task: task)
        }
        catch {
            repositoryError = error as? TaskRepositoryError
            showErrorAlert = true
            return false
        }
    }
    
    func updateTask(_ task: TaskItem) -> Bool {
        do {
            return try taskRepository.update(task: task)
        }
        catch {
            repositoryError = error as? TaskRepositoryError
            showErrorAlert = true
            return false
        }
    }
    
    func deleteTask(_ task: TaskItem) -> Bool {
        do {
            return try taskRepository.delete(using: task.id)
        }
        catch {
            repositoryError = error as? TaskRepositoryError
            showErrorAlert = true
            return false
        }
    }
}

