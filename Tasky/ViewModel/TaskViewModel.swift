//
//  TaskViewModel.swift
//  Tasky
//
//  Created by Arun on 06/08/24.
//

import Foundation

class TaskViewModel : ObservableObject {
    
    private var tempTasks = TaskItem.createMockTaskItems()
    
    @Published var tasks = [TaskItem]()
    
    func showTasks(completed: Bool) {
        tasks = tempTasks.filter({ $0.isCompleted == completed })
    }
    
    func addTask(_ task: TaskItem) {
        
        let taskItem = TaskItem(
            id: tempTasks.count,
            name: task.name,
            description: task.description,
            isCompleted: task.isCompleted,
            finishedDate: task.finishedDate
        )
        
        tempTasks.append(taskItem)
    }
    
    func updateTask(_ task: TaskItem) -> Bool {
        
        if let existingTaskIndex = tempTasks.firstIndex(where: {  $0.id == task.id })  {
            
            tempTasks[existingTaskIndex].name = task.name
            tempTasks[existingTaskIndex].description = task.description
            tempTasks[existingTaskIndex].isCompleted = task.isCompleted
            tempTasks[existingTaskIndex].finishedDate = task.finishedDate
            
            return true
        }
        
        return false
    }
    
    @discardableResult
    func deleteTask(_ task: TaskItem) -> Bool {
        
        if let existingTaskIndex = tempTasks.firstIndex(where: {  $0.id == task.id }) {
            tempTasks.remove(at: existingTaskIndex)
            return true
        }
        
        return false
    }
}

