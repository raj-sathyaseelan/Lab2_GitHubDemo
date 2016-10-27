//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD
import AFNetworking

// Main ViewController
class RepoResultsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, SettingsViewControllerDelegate {


    @IBOutlet weak var reposTableView: UITableView!
    
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings(searchString: "", minStars: 0, language: [Language]())
    var repos: [GithubRepo]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        //Initialize tableView
        reposTableView.delegate = self
        reposTableView.dataSource = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        reposTableView.rowHeight = 200
    
        // Perform the first search when the view controller first loads
        doSearch()
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)
        print("search settings: \(searchSettings.searchString)")
        
        repos = [GithubRepo]()

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
                self.repos.append(repo)
            }   

            self.reposTableView.reloadData()
            
            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.tab
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GitRepoTableViewCell") as! GithubRepoTableViewCell
        cell.repoNameLabel.text = repos[indexPath.row].name!
        cell.repoDescLabel.text = repos[indexPath.row].desc!
        cell.repoForksLabel.text = "\(repos[indexPath.row].forks!)"
        cell.repoStarsLabel.text = "\(repos[indexPath.row].stars!)"
        cell.repoAuthorLabel.text = "By \(repos[indexPath.row].ownerHandle!)"
        
        cell.repoNameLabel.sizeToFit()
        cell.repoDescLabel.sizeToFit()
        cell.repoForksLabel.sizeToFit()
        cell.repoStarsLabel.sizeToFit()
        cell.repoAuthorLabel.sizeToFit()
        cell.repoAvatarImageView.setImageWith(URL(string: repos[indexPath.row].ownerAvatarURL!)!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "Settings" {
            
            if let nav = segue.destination as? UINavigationController {
                
                if let settingsViewController = nav.topViewController as? SettingsViewController {
                    
                    settingsViewController.searchSettings =  self.searchSettings
                    settingsViewController.delegate = self
                }

        
            }
            
            /*
            if let dest = segue.destination as!
                SettingsViewController {
                
                //let path = tableView.indexPathForSelectedRow
                //let cell = tableView.cellForRowAtIndexPath(path!)
                //destination.viaSegue = (cell?.textLabel?.text!)!
                
            }
             */
        }
        
        //let np = segue.destination as! SettingsViewController
        //np.searchSettings =  self.searchSettings
        
        /*
        let index = GithubRepoTableViewCell.indexPath(for: sender as! UITableViewCell)
        
        if let row = index?.row {
            
            //to fix the row path
            np.flick = Flicks[(row)]
        }
        */
        
    }
    
    func settingsView(settingsView: SettingsViewController, didSettingsChange settings: GithubRepoSearchSettings?) {
        //code to update settings and reload results
        //update settings
        self.searchSettings = settings!
        
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? SettingsViewController {
            
            let settings = sourceViewController.searchSettings
            self.searchSettings = settings
            print("\(settings.minStars)")
            
            //reload table view
            doSearch()
            
        }
        
    }
    
    
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
