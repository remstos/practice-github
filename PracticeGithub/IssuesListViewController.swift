//
//  IssuesListViewController.swift
//  PracticeGithub
//
//  Created by Remi Santos on 13/11/2019.
//  Copyright © 2019 Rems Inc. All rights reserved.
//

import UIKit

class IssuesListViewController: UITableViewController {

    // Data
    var repository: Repository?
    var issues: [Issue] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = self.repository?.name

        self.issues = [
            Issue(title: "Issue #1"),
            Issue(title: "Issue #2"),
            Issue(title: "Issue #3")
        ]
    }

    // MARK: - Table View Datasource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.issues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let issue = self.issues[indexPath.row]
        let cell = tableView .dequeueReusableCell(withIdentifier: "IssueCell", for: indexPath)
        
        cell.textLabel?.text = issue.title

        return cell
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}
