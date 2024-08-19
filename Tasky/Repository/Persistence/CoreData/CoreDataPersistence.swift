//
//  CoreDataPersistence.swift
//  Tasky
//
//  Created by Arun on 06/08/24.
//

import CoreData

class CoreDataPersistence {
    
    static let shared = CoreDataPersistence()
    
    private let container: NSPersistentContainer
    
    let context: NSManagedObjectContext
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Tasky")
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        context = container.viewContext
    }
    
    @discardableResult
    func saveContext() throws -> Bool {
        
        guard context.hasChanges else { return false }
        
        do {
            try context.save()
            return true
        }
        catch {
            context.rollback()
            throw error
        }
    }
}
