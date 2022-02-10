//
//  CoreDataStack.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 10.2.2022.
//

import Foundation
import CoreData

final class CoreDataStack{
    
    private init(){}
    
    static let shared = CoreDataStack()
    
    // MARK: - Core Data stack
    
    lazy var context = persistentContainer.viewContext

    lazy var persistentContainer: NSPersistentContainer = {

       let container = NSPersistentContainer(name: "APOD")
       container.loadPersistentStores(completionHandler: { (storeDescription, error) in
           if let error = error as NSError? {

               fatalError("Unresolved error \(error), \(error.userInfo)")
           }
       })
       return container
   }()

   // MARK: - Core Data Saving support

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
    
    // MARK: - Generic Fetch
    
    func fetchRequest<T: NSManagedObject>(managedObject: T.Type)-> [T]?{
        
        do {
            guard let result = try context.fetch(managedObject.fetchRequest()) as? [T] else { return nil }
            
            return result
            
        } catch let error {
            
            debugPrint(error.localizedDescription)
        }
        return nil
    }
}
