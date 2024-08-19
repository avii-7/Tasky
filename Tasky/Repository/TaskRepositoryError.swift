//
//  TaskRepositoryError.swift
//  Tasky
//
//  Created by Arun on 16/08/24.
//

import Foundation

enum TaskRepositoryError: Equatable {
    case localStorageError(cause: String)
}

extension TaskRepositoryError : LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .localStorageError(let cause):
            return cause
        }
    }
}
