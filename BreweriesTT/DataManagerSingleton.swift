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
        
        URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)

        
        let request = AF.request("https://api.openbrewerydb.org/breweries")
        
        request
            .validate()
            .responseDecodable(of: [Brewery].self) { (response) in
                guard let breweies = response.value else { return }
                
                self.deleteAllFromCoreData()
                self.updateCoreData(withNew: breweies)
                print("New breweries loaded and added to core data!")
                
                complition(breweies.sorted { $0.id < $1.id })
            }
        
        
        return fetchCoreData()
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
        
        let queue = DispatchQueue(label: "Updating databse", qos: .background)
        queue.async {
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
    
        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false
        
        do {
            let items = try managedContext.fetch(fetchRequest) as! [NSManagedObject]

            for item in items {
                managedContext.delete(item)
            }
            /// Save Changes
            try managedContext.save()
            
        } catch {
            print("Could not delete. \(error)")
        }
    }
    
}
