//
//  GithubNetworkManager.swift
//  PracticeGithub
//
//  Created by Remi Santos on 17/11/2019.
//  Copyright © 2019 Rems Inc. All rights reserved.
//

import Foundation
import Alamofire

/// Handling network communication for Github repositories
class GithubNetworkManager : RepositoryNetworkManager {
    
    override func urlToFetchIssues() -> URL? {
        return URL(string: self.repository.url)
    }
    
    override func fetchIssues(withCompletion completion: (([Issue], Error?) -> Void)) {
        
        AF.request("https://httpbin.org/get").response { response in
            debugPrint(response)
        }
        completion([], nil)
    }
}
