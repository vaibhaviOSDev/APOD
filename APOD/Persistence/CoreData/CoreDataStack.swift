//
//  CoreDataStack.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 10.2.2022.
//

import Foundation
import CoreData

final class CoreDataStack{
    
    // MARK: - Private Init
    private init(){}
    
    /// Single point of access
    static let shared = CoreDataStack()
    
    // MARK: - Core Data stack
    
    /// Context using which the changes are saved to the store Coordinator
    lazy var context = persistentContainer.viewContext
    /// Persistence container which will hold all the objects passed & later will write to the model
    lazy var persistentContainer: NSPersistentContainer = {

       let container = NSPersistentContainer(name: "APOD")
       container.loadPersistentStores(completionHandler: { (storeDescription, error) in
           if let error = error as NSError? {

               fatalError("Unresolved error \(error), \(error.userInfo)")
           }
       })
       return container
   }()

   // MARK: - Save
    
    /// Without executing this method the changes won't persist.
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
   // MARK: - Execute Fetch
    /// Fetches all the records of respective entities
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
