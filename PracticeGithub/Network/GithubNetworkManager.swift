//
//  GithubNetworkManager.swift
//  PracticeGithub
//
//  Created by Remi Santos on 17/11/2019.
//  Copyright © 2019 Rems Inc. All rights reserved.
//

import Foundation

/// Handling network communication for Github repositories
class GithubNetworkManager : RepositoryNetworkManager {
    
    override func urlToFetchIssues() -> URL? {
        return URL(string: self.repository.url)
    }
    
    override func fetchIssues(withCompletion completion: (([Issue], Error?) -> Void)) {
        
        
        completion([])
    }
}
