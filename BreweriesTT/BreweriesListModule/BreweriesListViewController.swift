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
    
    var breweries: [Brewery] = []
    var breweriesInSearch: [Brewery] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    var isSearching: Bool = false
    var pendingRequestWorkItem: DispatchWorkItem?

    let dataManager = DataManagerSingleton.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchAndNavigation()
        
        // Getting data
        dataManager.getBreweries(fromCoreData: { [weak self] breweriesFromCoreData in
            self?.breweries = breweriesFromCoreData
            
            // If brews from core data is empty, start loading
            if breweriesFromCoreData.isEmpty {
                self?.searchController.searchBar.isLoading = true
            }
        }, fromServer: { [weak self] breweriesFromServer in
            self?.breweries = breweriesFromServer
            // Stop loading
            self?.searchController.searchBar.isLoading = false
            self?.tableView.reloadData()
        })

        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: BreweryTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: BreweryTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Setup table view background
        let tableViewBackgroundImage = UIImage(named: "background")
        let tableViewBackgroundImageView = UIImageView(frame: tableView.frame)
        tableViewBackgroundImageView.image = tableViewBackgroundImage
        tableViewBackgroundImageView.contentMode = .bottomRight
        tableView.backgroundView = tableViewBackgroundImageView
        
        // Setup table view content
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
    }
    
    private func setupSearchAndNavigation() {
        // Navaigation
        self.title = "Breweries"
        
        // Search
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController

        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barStyle = .default
        
        searchController.definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.setCenteredPlaceHolder()
        
        // Search bar apppearance
        searchController.searchBar.textField?.tintColor = UIColor.black
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor.white
        
        if #available(iOS 13.0, *) {
            searchController.searchBar.textField?.backgroundColor = UIColor.white
        } else {
            if let textField = searchController.searchBar.textField {
                if let backgroundview = textField.subviews.first {
                    backgroundview.backgroundColor = UIColor.white
                    backgroundview.layer.cornerRadius = 10;
                    backgroundview.clipsToBounds = true;
                }
            }
        }
        
    }
    
}


extension BreweriesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? breweriesInSearch.count : breweries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BreweryTableViewCell.identifier) as? BreweryTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.backgroundView = UIView()
        cell.selectedBackgroundView = UIView()
        
        cell.brewery = isSearching ? breweriesInSearch[indexPath.row] : breweries[indexPath.row]
        return cell
    }

}


extension BreweriesListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        let lowerCaseSearchText = searchText.lowercased()
        
        if lowerCaseSearchText.isEmpty {
            isSearching = false
            breweriesInSearch = breweries
            searchController.searchBar.isLoading = false
        } else {
            isSearching = true
        }
        
        // Cancel previous request
        pendingRequestWorkItem?.cancel()

        if isSearching {
            // Start loading activity indicator
            searchController.searchBar.isLoading = true
            
            // While waiting for response from server, filter available breweries
            breweriesInSearch = breweriesInSearch.filter { $0.name.lowercased().contains(lowerCaseSearchText) }.sorted(by: { $0.id < $1.id })

            // Wrap our request in a work item
            let requestWorkItem = DispatchWorkItem { [weak self] in
                self?.dataManager.getBreweriesQuery(with: searchText) { newBrews in
                    // Stop loading
                    self?.searchController.searchBar.isLoading = false
                    
                    // Apply new breweries
                    self?.breweriesInSearch = newBrews
                    print("Find on server \(self?.breweriesInSearch.count ?? -1) breweries")
                    
                    // Reload data
                    self?.tableView.reloadData()
                }
            }
            
            // Save the new work item and execute it after 500 ms (if user dont change any text)
            pendingRequestWorkItem = requestWorkItem
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: requestWorkItem)
        }

        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.isLoading = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchController.searchBar.setLeftPlaceHolder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchController.searchBar.setCenteredPlaceHolder()
    }
    
}
