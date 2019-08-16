//
//  DataStore.swift
//  CoreDataDemo
//
//  Created by Joshua on 8/16/19.
//  Copyright © 2019 Matthew Dias. All rights reserved.
//

import Foundation
import CoreData


class DataStore {
    
    static var shared = DataStore()
    
    // helper object to make use easier
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // private init to prevent accidental initializations in the app
    private init() { }
    
    
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { (storeDescription, error) in
            if let nserror = error as NSError? {
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
        return container
    }()
    
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
