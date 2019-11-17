//
//  NetworkManager.swift
//  PracticeGithub
//
//  Created by Remi Santos on 16/11/2019.
//  Copyright © 2019 Rems Inc. All rights reserved.
//

import Foundation


/**
 Handling network request for a repository.
 
 Subclass for different hosting provider (Github, Bitbucket, ..).
 */
class RepositoryNetworkManager {
    internal var repository :Repository!

    class func networkManagerForRepository(_ repository: Repository) -> RepositoryNetworkManager {
        // return the right network manager from the repo url.
        if (repository.url.contains("github.com")) {
            return GithubNetworkManager(withRepository: repository)
        } else {
            // implement more hosting providers.
            return TestRepositoryNetworkManager(withRepository:repository)
        }
    }
    
    init(withRepository: Repository) {
        repository = withRepository
    }
    
    internal func urlToFetchIssues() -> URL? {
        return URL(string: "override-this")
    }
    
    internal func fetchIssues(withCompletion completion: @escaping (([Issue]?, Error?) -> Void)) {
        guard let url = self.urlToFetchIssues() else {
            completion([], nil)//Error(description: "url not found"))
            return
        }
        
        // do some network fetching
        print("fetching issues from: \(url)")
        let issues: [Issue] = []
        completion(issues, nil)
    }
}

// MARK: - Test data
/// Mocking data
class TestRepositoryNetworkManager : RepositoryNetworkManager {
    
    override func fetchIssues(withCompletion completion: @escaping (([Issue]?, Error?) -> Void)) {
        completion([
            Issue(title: "Issue #1"),
            Issue(title: "Issue #2"),
            Issue(title: "Issue #3")
        ], nil)
    }
}
