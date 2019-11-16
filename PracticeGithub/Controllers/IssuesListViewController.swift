//
//  IssuesListViewController.swift
//  PracticeGithub
//
//  Created by Remi Santos on 13/11/2019.
//  Copyright © 2019 Rems Inc. All rights reserved.
//

import UIKit

class IssuesListViewController: UITableViewController, UISearchControllerDelegate, UISearchResultsUpdating {
    
    // Data
    private var repository: Repository?
    private var issues: [Issue] = []
    private var displayedIssues: [Issue] = []
    
    private var networkManager: NetworkManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.repository?.name
        self.setupSearchController()
    }
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }
    
    private func loadIssues() {
        guard self.networkManager != nil else {
            return;
        }
        self.networkManager?.fetchIssues(withCompletion: { (issues, error) in
            guard error == nil else {
                return self.showAlertFromError(error!)
            }
            self.issues = issues
            self.updateDisplayedIssuesForSearchTerm(nil)
            self.tableView.reloadData()
        })
    }
    
    private func updateDisplayedIssuesForSearchTerm(_ searchTerm: String?) {
        guard searchTerm != nil else {
            self.displayedIssues = self.issues
            return
        }
        let textToSearch = searchTerm!.lowercased()
        self.displayedIssues = self.issues.filter({ (issue) -> Bool in
            return issue.title.lowercased().contains(textToSearch)
        })
    }
    
    private func showAlertFromError(_ error: Error) {
        
    }
    
    func setupWithRepository(repository: Repository) {
        self.repository = repository;
        self.networkManager = NetworkManager.networkManagerForRepository(repository)
        self.loadIssues()
    }

    // MARK: - Table View Datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayedIssues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let issue = self.displayedIssues[indexPath.row]
        let cell = tableView .dequeueReusableCell(withIdentifier: "IssueCell", for: indexPath)
        
        cell.textLabel?.text = issue.title

        return cell
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "IssueDetail", sender: tableView.cellForRow(at: indexPath))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndex = self.tableView.indexPathForSelectedRow,
            let navController = segue.destination as? UINavigationController,
            let controller = navController.topViewController as? IssueDetailViewController,
            segue.identifier == "IssueDetail" {
            
            let selectedIssue = self.displayedIssues[selectedIndex.row]
            controller.setupWithIssue(selectedIssue)
        }
    }
    
    // MARK: - Search delegate
    func updateSearchResults(for searchController: UISearchController) {
        self .updateDisplayedIssuesForSearchTerm(searchController.searchBar.text)
        self.tableView.reloadData()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        self.updateDisplayedIssuesForSearchTerm(nil)
        self.tableView.reloadData()
    }
}
