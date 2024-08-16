//
//  TaskRepositoryError.swift
//  Tasky
//
//  Created by Arun on 16/08/24.
//

import Foundation

enum TaskRepositoryError {
    case add, update, delete, get, failed
}

extension TaskRepositoryError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .add:
            "Failed to add an item."
        case .update:
            "Failed to update an item."
        case .delete:
            "Failed to delete an item from list."
        case .get:
            "Failed to get items."
        case .failed:
            "Failed"
        }
    }
}
