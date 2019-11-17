//
//  Repository.swift
//  PracticeGithub
//
//  Created by Remi Santos on 13/11/2019.
//  Copyright © 2019 Rems Inc. All rights reserved.
//

import Foundation

struct Repository : Codable {
    
    let url: String
    let name: String
    let username: String
    
    init(fromUrl: String) {
        self.url = fromUrl
        if let URLObject = URL(string: fromUrl), URLObject.pathComponents.count > 2 {
            let pathComponents = URLObject.pathComponents
            self.name = pathComponents.last!.replacingOccurrences(of: ".git", with: "")
            self.username = pathComponents[pathComponents.count - 2]
        } else {
            self.name = url
            self.username = url
        }
    }
    
    init(url: String, name: String, username: String) {
        self.url = url
        self.name = name
        self.username = username
    }
}

