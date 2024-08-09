//
//  TaskItem.swift
//  Tasky
//
//  Created by Arun on 06/08/24.
//

import Foundation

struct TaskItem {
    let id: Int
    var name: String
    var description: String
    var isCompleted: Bool
    var finishedDate: Date
}

extension TaskItem {
    static func createMockTaskItems() -> [TaskItem] {
        
        let arr: [TaskItem] = [
            TaskItem(id: 0, name: "Exercise", description: "Peform full body exercise outside. Keep the water bottle with you.", isCompleted: true, finishedDate: .now),
            TaskItem(id: 1, name: "Bath", description: "Take Bath", isCompleted: true, finishedDate: .now),
            TaskItem(id: 2, name: "Breakfast", description: "Morning meal", isCompleted: false, finishedDate: .now),
            TaskItem(id: 3, name: "Coffee", description: "Drink Coffee", isCompleted: false, finishedDate: .now),
        ]
        
        return arr
    }
}
