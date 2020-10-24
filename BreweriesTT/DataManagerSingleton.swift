//
//  DataManager.swift
//  BreweriesTT
//
//  Created by Денис Данилюк on 24.10.2020.
//

import UIKit
import CoreData
import Alamofire

class DataManagerSingleton {
    
    static let shared = DataManagerSingleton()
    
    init () {}
    
    func getData(complition: @escaping ([Brewery]) -> ()) -> [Brewery] {
        let request = AF.request("https://api.openbrewerydb.org/breweries")
        
        request
            .validate()
            .responseDecodable(of: [Brewery].self) { (response) in
                guard let breweies = response.value else { return }
                self.updateCoreData(withNew: breweies)
                print("New breweries loaded and added to core data!")
                
                complition(breweies.sorted { $0.id < $1.id })
            }
        
        return fetchCoreData()
    }
    
    func getBreweries(with name: String, complition: @escaping ([Brewery]) -> ()) {
        let request = AF.request("https://api.openbrewerydb.org/breweries", parameters: ["by_name": name])
        
        request
            .validate()
            .responseDecodable(of: [Brewery].self) { (response) in
                guard let breweies = response.value else { return }
                complition(breweies.sorted { $0.id < $1.id })
            }
    }
    
    func fetchCoreData() -> [Brewery] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let breweryCoreData = try? managedContext.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: BreweryData.self))) as? [BreweryData] else { return [] }
        
        return breweryCoreData.map({ $0.wrappedBrewery }).sorted { $0.id < $1.id }
    }
    
    func updateCoreData(withNew breweries: [Brewery]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        self.deleteAllFromCoreData()

        DispatchQueue.main.async {
            for brewery in breweries {
                let breweryData = BreweryData(context: managedContext)
                breweryData.fillWith(brewery: brewery)
            }
            do {
                if managedContext.hasChanges {
                    try managedContext.save()
                }
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func deleteAllFromCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BreweryData")
    
        fetchRequest.includesPropertyValues = false
        do {
            let items = try managedContext.fetch(fetchRequest) as! [NSManagedObject]

            for item in items {
                managedContext.delete(item)
            }
            try managedContext.save()
        } catch {
            print("Could not delete. \(error)")
        }
    }
    
}
