//
//  ViewController.swift
//  BreweriesTT
//
//  Created by Денис Данилюк on 23.10.2020.
//

import UIKit

class BreweriesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    

    var brews: [Brewery] = [
        Brewery(id: 1, name: "Avondale Brewing Co", breweryType: .brewpub, street: "201 41st St S", address2: nil, address3: nil, city: "Kyiv", state: "", countyProvince: nil, postalCode: "", country: "", longitude: "", latitude: "", phone: "123", websiteURL: "www.some.ua", updatedAt: "123"),
        
        Brewery(id: 2, name: "Avondal", breweryType: .brewpub, street: "2013 41st St S", address2: nil, address3: nil, city: "Lviv", state: "", countyProvince: nil, postalCode: "", country: "", longitude: "", latitude: "", phone: "123", websiteURL: "", updatedAt: "123")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        self.title = "Breweries"
        
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: BreweryTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: BreweryTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
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
