//
//  TestInMemoryStore.swift
//  PracticeGithub
//
//  Created by Remi Santos on 17/11/2019.
//  Copyright © 2019 Rems Inc. All rights reserved.
//

import Foundation

/// Store not persisting data, providing test data.
class TestInMemoryStore: Store {
    
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
