//
//  CoreDataStack.swift
//  movies
//
//  Created by Yonny on 15/04/25.
//

import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieDataModel") // <- usa el nombre exacto de tu .xcdatamodeld
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Error al cargar Core Data: \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try? context.save()
        }
    }
    
}
