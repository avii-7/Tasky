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
            let result = taskRepository.getAll(isCompleted: isCompleted)
            
            switch result {
            case .success(let taskItems):
                self.taskItems = taskItems
            case .failure(let failure):
                showError(error: failure)
            }
        }
    }
    
    func addTask(_ task: TaskItem) -> Bool {
        let result = taskRepository.add(task: task)
        switch result {
        case .success:
            return true
        case .failure(let failure):
            showError(error: failure)
            return false
        }
    }
    
    func updateTask(_ task: TaskItem) -> Bool {
        let result = taskRepository.update(task: task)
        switch result {
        case .success:
            return true
        case .failure(let failure):
            showError(error: failure)
            return false
        }
    }
    
    func deleteTask(_ task: TaskItem) -> Bool {
        let result = taskRepository.delete(using: task.id)
        switch result {
        case .success:
            return true
        case .failure(let failure):
            showError(error: failure)
            return false
        }
    }
    
    private func showError(error: TaskRepositoryError) {
        repositoryError = error
        showErrorAlert = true
    }
}

