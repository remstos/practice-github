//
//  UserDefaultsStore.swift
//  PracticeGithub
//
//  Created by Remi Santos on 17/11/2019.
//  Copyright © 2019 Rems Inc. All rights reserved.
//

import Foundation

/// Store Persisting data in User Defaults
class UserDefaultsStore: Store {
    
    private let UDRepositoriesKey = "Repositories"
    
    private func saveRepositories(_ repositories:[Repository]) {
        if let data = try? JSONEncoder().encode(repositories) {
            UserDefaults.standard.set(data, forKey: UDRepositoriesKey)
        }
    }

    // MARK: - Store Protocol
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
