//
//  RepositoriesListViewController.swift
//  PracticeGithub
//
//  Created by Remi Santos on 13/11/2019.
//  Copyright © 2019 Rems Inc. All rights reserved.
//

import UIKit

class RepositoriesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Data
    var dataSource = DataSource(withStore:
        CoreDataStore()
//        UserDefaultsStore()
//        TestStore()
    )
    
    // Views
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Repositories"
        self.loadData()
    }
    
    private func loadData() {
        self.dataSource.loadRepositories { (error) in
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New repository", message: "Enter the url of the repository you want to follow", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default) { (action) in
            if let url = alert.textFields![0].text {
                self.dataSource.addRepositoryFromURL(URL: url, completion: { (index, error) in
                    self.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                })
            }
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table View Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repo = self.dataSource.repositories[indexPath.row]
        let cell = tableView .dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath)
        
        cell.textLabel?.text = repo.name.capitalized

        return cell
    }
    
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let repo = self.dataSource.repositories[indexPath.row]
            self.dataSource.deleteRepository(repo) { (error) in
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "RepositoryDetail", sender: tableView.cellForRow(at: indexPath))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndex = self.tableView.indexPathForSelectedRow,
            let controller = segue.destination as? IssuesListViewController,
            segue.identifier == "RepositoryDetail" {
            
            let selectedRepo = self.dataSource.repositories[selectedIndex.row]
            controller.setupWithRepository(repository:selectedRepo)
        }
    }
}

