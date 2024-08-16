//
//  TaskViewModel.swift
//  Tasky
//
//  Created by Arun on 06/08/24.
//

import Foundation

class TaskViewModel : ObservableObject {
    
    @Published var taskItems = [TaskItem]()
    
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
        taskItems = taskRepository.getAll(isCompleted: isCompleted)
    }
    
    func addTask(_ task: TaskItem) -> Bool {
        taskRepository.add(task: task)
    }
    
    func updateTask(_ task: TaskItem) -> Bool {
        taskRepository.update(task: task)
    }

    func deleteTask(_ task: TaskItem) -> Bool {
        taskRepository.delete(using: task.id)
    }
}

