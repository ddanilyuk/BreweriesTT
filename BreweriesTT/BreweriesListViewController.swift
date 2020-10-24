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
    
    let search = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Breweries"
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "MainColor")

        
        setupTableView()
        setupSearch()
        fetchBreweries()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: BreweryTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: BreweryTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
    }
    
    private func setupSearch() {
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "Search"
        
        search.searchBar.barStyle = .default
        
        search.hidesNavigationBarDuringPresentation = true
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.tintColor = UIColor.white
        search.searchBar.getTextField()?.tintColor = UIColor.black
        self.navigationItem.searchController = search
        
        search.searchBar.setTextField(color: UIColor.white)


        search.searchBar.getTextField()?.textAlignment = .left


    }
    
    func fetchBreweries() {
        let request = AF.request("https://api.openbrewerydb.org/breweries")
    
        request
            .validate()
            .responseDecodable(of: [Brewery].self) { (response) in
                guard let breweies = response.value else { return }
                self.brews = breweies
                self.tableView.reloadData()
                print(breweies)
           }
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
    
    // This delete empty cells
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    
    
}


extension BreweriesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
