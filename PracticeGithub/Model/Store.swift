//
//  Store.swift
//  PracticeGithub
//
//  Created by Remi Santos on 15/11/2019.
//  Copyright © 2019 Rems Inc. All rights reserved.
//

import Foundation

typealias ErrorCompletionBlock = (Error?) -> Void
protocol Store {
    
    func fetchRepositories(completion: ([Repository]) -> Void)
    func createRepository(repository: Repository, completion: (Int, Error?) -> Void)
    func updateRepository(repository: Repository, completion: ErrorCompletionBlock)
    func deleteRepository(repository: Repository, completion: ErrorCompletionBlock)
}

// Test data - In Memory store
class TestStore: Store {
    
    var store = ["Repositories":
        [
            Repository(url: "github.com/january", name: "January"),
            Repository(url: "github.com/april", name: "April"),
            Repository(url: "github.com/yellow", name: "Yellow-Fork")
        ]
    ]
    func fetchRepositories(completion: ([Repository]) -> Void) {
        completion(store["Repositories"]!)
    }

    func createRepository(repository: Repository, completion: (Int, Error?) -> Void) {
        store["Repositories"]?.insert(repository, at: 0)
        completion(0, nil)
    }
    
    private func indexForRepository(_ repository: Repository) -> Int? {
        return store["Repositories"]?.firstIndex(where: { (repo) -> Bool in
            return repo.url == repository.url
        })
    }
    
    func updateRepository(repository: Repository, completion: (Error?) -> Void) {
        if let index = self.indexForRepository(repository) {
            store["Repositories"]![index] = repository
            completion(nil)
        } else {
            self.createRepository(repository: repository) { (index, error) in
                completion(error)
            }
        }
    }
    
    func deleteRepository(repository: Repository, completion: (Error?) -> Void) {
        if let index = self.indexForRepository(repository) {
            store["Repositories"]?.remove(at: index)
            completion(nil)
        } else {
            completion(NSError(domain: "Couldn't find repository to delete", code: 1, userInfo: nil))
        }
    }
}

// UserDefaults database
class UserDefaultsStore: Store {
    
    func fetchRepositories(completion: ([Repository]) -> Void) {
        
        var repos = UserDefaults.standard.object(forKey: "PGRepositories") as? [Repository]
        if (repos != nil) {
            repos = []
        }
        
        completion(repos!)
    }

    
    func createRepository(repository: Repository, completion: (Int, Error?) -> Void) {
        
    }
    
    func updateRepository(repository: Repository, completion: (Error?) -> Void) {
        
    }
    
    func deleteRepository(repository: Repository, completion: (Error?) -> Void) {
        
    }
}

// CoreData database
class CoreDataStore: Store {
    
    func fetchRepositories(completion: ([Repository]) -> Void) {        
        completion([])
    }

    
    func createRepository(repository: Repository, completion: (Int, Error?) -> Void) {
        
    }
    
    func updateRepository(repository: Repository, completion: (Error?) -> Void) {
        
    }
    
    func deleteRepository(repository: Repository, completion: (Error?) -> Void) {
        
    }
}
