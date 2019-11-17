//
//  GithubNetworkManager.swift
//  PracticeGithub
//
//  Created by Remi Santos on 17/11/2019.
//  Copyright © 2019 Rems Inc. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/// Handling network communication for Github repositories
class GithubNetworkManager : RepositoryNetworkManager {
    
    lazy var repoApiURL: String = {
        return "https://api.github.com/repos/\(self.repository.username)/\(self.repository.name)"
    }()
    
    override func urlToFetchIssues() -> URL? {
        return URL(string: self.repoApiURL)
    }
    
    override func fetchIssues(withCompletion completion: @escaping (([Issue]?, Error?) -> Void)) {
        guard let baseURL = self.urlToFetchIssues() else {
            completion([], NSError(domain: "incorrect github url", code: 1, userInfo: nil))
            return
        }
        AF.request("\(baseURL)/issues").responseJSON { response in

            if let json = response.data{
                
                do {
                    let data = try JSON(data: json)
                    var result: [Issue] = []

                    if let array = data.array {
                        for issueJSON in array {
                            if let issue = self.issueFromJSONIssue(issueJSON) {
                                result.append(issue)
                            }
                        }
                    }
                    completion(result, nil)
                }
                catch {
                    completion(nil, NSError(domain: "Github: Error with returned data", code: 1, userInfo: nil))
                }
            } else {
                completion(nil, NSError(domain: "Github: Error no data fetched", code: 1, userInfo: nil))
            }
            
        }
    }
    
    private func issueFromJSONIssue(_ JSONIssue: JSON) -> Issue? {
        
        guard let title = JSONIssue["title"].string else {
            return nil
        }
        return Issue(title: title)
    }
}
