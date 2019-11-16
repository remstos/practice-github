//
//  NetworkManager.swift
//  PracticeGithub
//
//  Created by Remi Santos on 16/11/2019.
//  Copyright © 2019 Rems Inc. All rights reserved.
//

import Foundation


class NetworkManager {
    internal var repository :Repository!

    class func networkManagerForRepository(_ repository: Repository) -> NetworkManager {
        // return the right network manager from the repo url.
        return TestNetworkManager(withRepository:repository)
    }
    
    init(withRepository: Repository) {
        repository = withRepository
    }
    
    internal func urlToFetchIssues() -> URL? {
        return URL(string: "override-this")
    }
    
    internal func fetchIssues(withCompletion completion: (([Issue], Error?) -> Void)?) {
        guard let url = self.urlToFetchIssues() else {
            completion?([], nil)//Error(description: "url not found"))
            return
        }
        
        // do some network fetching
        print("fetching issues from: \(url)")
        let issues: [Issue] = []
        completion?(issues, nil)
    }
}

// Mark: - Test data
// No networking
class TestNetworkManager : NetworkManager {
    
    override func fetchIssues(withCompletion completion: (([Issue], Error?) -> Void)?) {        
        completion?([
            Issue(title: "Issue #1"),
            Issue(title: "Issue #2"),
            Issue(title: "Issue #3")
        ], nil)
    }
}

// Mark: - Github
class GithubNetworkManager : NetworkManager {
    
    override func urlToFetchIssues() -> URL? {
        return URL(string: self.repository.url)
    }
}
