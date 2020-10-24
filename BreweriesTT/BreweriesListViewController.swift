//
//  ViewController.swift
//  BreweriesTT
//
//  Created by Денис Данилюк on 23.10.2020.
//

import UIKit
import Alamofire


class BreweriesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var brews: [Brewery] = []
    var brewsInSearch: [Brewery] = []
    
    let search = UISearchController(searchResultsController: nil)
    var isSearching: Bool = false

    let dataManager = DataManagerSingleton.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchAndNavigation()
        
        brews = dataManager.getData { newBrews in
            // Receiving new brews from server
            self.brews = newBrews
            self.tableView.reloadData()
        }
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: BreweryTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: BreweryTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Setup table view background
        let tableViewBackgroundImage = UIImage(named: "background")
        let tableViewBackroundImageView = UIImageView(frame: tableView.frame)
        tableViewBackroundImageView.image = tableViewBackgroundImage
        tableViewBackroundImageView.contentMode = .bottomRight
        tableView.backgroundView = tableViewBackroundImageView
        
        // Setup
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
    }
    
    private func setupSearchAndNavigation() {
        // Navaigation
        self.title = "Breweries"
        
        // Search
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        self.navigationItem.searchController = search

        search.searchBar.placeholder = "Search"
        search.searchBar.barStyle = .default
        
        search.obscuresBackgroundDuringPresentation = false
        
        search.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Search bar apppearance
        search.searchBar.getTextField()?.tintColor = UIColor.black
        search.searchBar.setTextField(color: UIColor.white)
        search.searchBar.tintColor = UIColor.white
    }
    
}


extension BreweriesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BreweryTableViewCell.identifier) as? BreweryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = .clear
        cell.backgroundView = UIView()
        cell.selectedBackgroundView = UIView()
        
        cell.brewery = brews[indexPath.row]
        
        return cell
    }

}


extension BreweriesListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("clicked")
    }

}
