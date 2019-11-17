//
//  RepositoryManagedObject.swift
//  PracticeGithub
//
//  Created by Remi Santos on 17/11/2019.
//  Copyright © 2019 Rems Inc. All rights reserved.
//
//

import Foundation
import CoreData

@objc(RepositoryManagedObject)
public class RepositoryManagedObject: NSManagedObject {

    class var entityName: String { get {
        return "Repositories"
    } }
    
    class func entityDescriptionForContext(_ context:NSManagedObjectContext) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: self.entityName, in: context)!
    }
    
    @NSManaged public var url: String?
    @NSManaged public var name: String?

    func setValuesFromRepository(_ repository: Repository) {
        self.url = repository.url
        self.name = repository.name
    }
    
    func converToStruct() -> Repository {
        return Repository(url: self.url!, name: self.name!)
    }

}
