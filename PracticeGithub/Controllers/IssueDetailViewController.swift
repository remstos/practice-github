//
//  IssueDetailViewController.swift
//  PracticeGithub
//
//  Created by Remi Santos on 16/11/2019.
//  Copyright © 2019 Rems Inc. All rights reserved.
//

import UIKit

class IssueDetailViewController: UIViewController {

    private var issue: Issue!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.issue.title        
    }
    
    func setupWithIssue(_ issue: Issue) {
        self.issue = issue
    }

}
