//
//  CoreDataStore.swift
//  PracticeGithub
//
//  Created by Remi Santos on 17/11/2019.
//  Copyright © 2019 Rems Inc. All rights reserved.
//

import Foundation
import CoreData

/// Store persisting data with Core Data
class CoreDataStore: Store {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PracticeGithub")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var managedContext: NSManagedObjectContext { get {
        return self.persistentContainer.viewContext
    } }
    
    func fetchRepositories(completion: ([Repository]) -> Void) {
        let context = self.managedContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: RepositoryManagedObject.entityName)
        if let result = try? context.fetch(request) as? [RepositoryManagedObject] {
            let repos = result.reversed().map { (mo) -> Repository in
                return mo.converToStruct()
            }
            completion(repos)
        } else {
            completion([])
        }
    }

    
    func createRepository(repository: Repository, completion: (Int, Error?) -> Void) {
        let context = self.managedContext
        let entityDescription = RepositoryManagedObject.entityDescriptionForContext(context)
        let managedObject = RepositoryManagedObject(entity: entityDescription, insertInto: context)
        managedObject.setValuesFromRepository(repository)
        do {
            try context.save()
            completion(0, nil)
        } catch let error as NSError {
            completion(0, error)
        }
    }
    
    func updateRepository(repository: Repository, completion: (Error?) -> Void) {
        let context = self.managedContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: RepositoryManagedObject.entityName)
        fetchRequest.predicate = NSPredicate(format: "url == %@", repository.url)
        
        if let result = try? context.fetch(fetchRequest) as? [RepositoryManagedObject],
            let repoToUpdate = result.first {
            repoToUpdate.setValuesFromRepository(repository)
            do {
                try context.save()
                completion( nil)
            } catch let error as NSError {
                completion(error)
            }
        } else {
            completion(NSError(domain: "Couldn't find repository to update", code: 3, userInfo: nil))
        }
    }
    
    func deleteRepository(repository: Repository, completion: (Error?) -> Void) {
        let context = self.managedContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: RepositoryManagedObject.entityName)
        deleteFetch.predicate = NSPredicate(format: "url == %@", repository.url)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            completion(nil)
        } catch let error as NSError {
            completion(error)
        }
    }
}
