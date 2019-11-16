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
        let url = URL(string: URLString)
        let repo = Repository(url: URLString, name: url!.lastPathComponent)
        self.store.createRepository(repository: repo) { (index, error) in
            self.didSaveRepository(repository: repo, atIndex: index)
            completion?(index, error)
        }
    }
    
    func didSaveRepository(repository: Repository, atIndex index:Int) {
        repositories.insert(repository, at: index)
    }
}
