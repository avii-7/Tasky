//
//  TaskEntity+CoreDataProperties.swift
//  Tasky
//
//  Created by Arun on 15/08/24.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var finishedDate: Date?
    @NSManaged public var taskDescription: String?

}

extension TaskEntity : Identifiable {

}
