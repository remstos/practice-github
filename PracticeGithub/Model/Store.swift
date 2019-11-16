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
    
    var inMemoryStorage = ["Repositories":
        [
            Repository(url: "github.com/january", name: "January"),
            Repository(url: "github.com/april", name: "April"),
            Repository(url: "github.com/yellow", name: "Yellow-Fork")
        ]
    ]
   
    private func indexForRepository(_ repository: Repository) -> Int? {
        return inMemoryStorage["Repositories"]?.firstIndex(where: { (repo) -> Bool in
            return repo.url == repository.url
        })
    }
    
    func fetchRepositories(completion: ([Repository]) -> Void) {
        completion(inMemoryStorage["Repositories"]!)
    }

    func createRepository(repository: Repository, completion: (Int, Error?) -> Void) {
        inMemoryStorage["Repositories"]?.insert(repository, at: 0)
        completion(0, nil)
    }
    
    func updateRepository(repository: Repository, completion: (Error?) -> Void) {
        if let index = self.indexForRepository(repository) {
            inMemoryStorage["Repositories"]![index] = repository
            completion(nil)
        } else {
            completion(NSError(domain: "Couldn't find repository to update", code: 2, userInfo: nil))
        }
    }
    
    func deleteRepository(repository: Repository, completion: (Error?) -> Void) {
        if let index = self.indexForRepository(repository) {
            inMemoryStorage["Repositories"]?.remove(at: index)
            completion(nil)
        } else {
            completion(NSError(domain: "Couldn't find repository to delete", code: 1, userInfo: nil))
        }
    }
}

// UserDefaults database
class UserDefaultsStore: Store {
    
    private let UDRepositoriesKey = "Repositories"
    
    private func saveRepositories(_ repositories:[Repository]) {
        if let data = try? JSONEncoder().encode(repositories) {
            UserDefaults.standard.set(data, forKey: UDRepositoriesKey)
        }
    }

    func fetchRepositories(completion: ([Repository]) -> Void) {
        
        if let data = UserDefaults.standard.object(forKey: UDRepositoriesKey) as? Data,
            let repos = try? JSONDecoder().decode([Repository].self, from: data) {
            completion(repos)
        } else {
            completion([])
        }
    }
    
    func createRepository(repository: Repository, completion: (Int, Error?) -> Void) {
        self.fetchRepositories { (repos) in
            var mutatedRepos = repos
            mutatedRepos.insert(repository, at: 0)
            self.saveRepositories(mutatedRepos)
            completion(0, nil)
        }
    }
    
    func updateRepository(repository: Repository, completion: (Error?) -> Void) {
        self.fetchRepositories { (repos) in
            var mutatedRepos = repos
            if let index = mutatedRepos.firstIndex(where: { (repo) -> Bool in
                return repo.url == repository.url
            }) {
                mutatedRepos[index] = repository
                self.saveRepositories(mutatedRepos)
                completion(nil)
            } else {
                completion(NSError(domain: "Couldn't find repository to update", code: 2, userInfo: nil))
            }
        }
    }
    
    func deleteRepository(repository: Repository, completion: (Error?) -> Void) {
        self.fetchRepositories { (repos) in
            var mutatedRepos = repos
            if let index = mutatedRepos.firstIndex(where: { (repo) -> Bool in
                return repo.url == repository.url
            }) {
                mutatedRepos.remove(at: index)
                self.saveRepositories(mutatedRepos)
                completion(nil)
            } else {
                completion(NSError(domain: "Couldn't find repository to delete", code: 1, userInfo: nil))
            }
        }
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
