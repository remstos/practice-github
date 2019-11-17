//
//  Store.swift
//  PracticeGithub
//
//  Created by Remi Santos on 15/11/2019.
//  Copyright © 2019 Rems Inc. All rights reserved.
//

import Foundation

typealias ErrorCompletionBlock = (Error?) -> Void

/// Store protocol to handle data change to backend.
protocol Store {
    
    func fetchRepositories(completion: ([Repository]) -> Void)
    func createRepository(repository: Repository, completion: (Int, Error?) -> Void)
    func updateRepository(repository: Repository, completion: ErrorCompletionBlock)
    func deleteRepository(repository: Repository, completion: ErrorCompletionBlock)

}
