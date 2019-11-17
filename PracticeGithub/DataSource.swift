//
//  DataSource.swift
//  PracticeGithub
//
//  Created by Remi Santos on 15/11/2019.
//  Copyright © 2019 Rems Inc. All rights reserved.
//

import Foundation

class DataSource {
    
    private(set) var repositories :[Repository] = []
    
    private var store :Store
    
    init(withStore:Store) {
        store = withStore
    }
    
    func loadRepositories(completion: ErrorCompletionBlock?) {
        self.store.fetchRepositories { (repos) in
            self.repositories = repos
            completion?(nil)
        }
    }
    
    func addRepositoryFromURL(URL URLString:String, completion: ((Int, Error?) -> Void)?) {
        let repo = Repository(fromUrl: URLString)
        self.store.createRepository(repository: repo) { (index, error) in
            self.didSaveRepository(repo, atIndex: index)
            completion?(index, error)
        }
    }
    
    private func didSaveRepository(_ repository: Repository, atIndex index:Int) {
        self.repositories.insert(repository, at: index)
    }
    
    func deleteRepository(_ repository: Repository, completion: ((Error?) -> Void)?) {
        self.store.deleteRepository(repository: repository) { (error) in
            if let index = self.repositories.firstIndex(where: { (rep) -> Bool in
                return rep.url == repository.url
            }) {
                self.repositories.remove(at: index)
            }
            completion?(error)
        }
    }
    
    func updateRepository(_ repository: Repository, completion: ((Error?) -> Void)?) {
        if let index = self.repositories.firstIndex(where: { (rep) -> Bool in
            return rep.url == repository.url
        }) {
            self.store.updateRepository(repository: repository) { (error) in
                self.repositories[index] = repository                
                completion?(error)
            }
        }
        
    }
    
}
