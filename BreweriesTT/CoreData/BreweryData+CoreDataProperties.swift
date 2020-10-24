//
//  BreweryData+CoreDataProperties.swift
//  BreweriesTT
//
//  Created by Денис Данилюк on 24.10.2020.
//
//

import Foundation
import CoreData


extension BreweryData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BreweryData> {
        return NSFetchRequest<BreweryData>(entityName: "BreweryData")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var breweryType: String?
    @NSManaged public var street: String?
    @NSManaged public var address2: String?
    @NSManaged public var address3: String?
    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var countyProvince: String?
    @NSManaged public var postalCode: String?
    @NSManaged public var country: String?
    @NSManaged public var longitude: String?
    @NSManaged public var latitude: String?
    @NSManaged public var phone: String?
    @NSManaged public var websiteURL: String?
    @NSManaged public var updatedAt: String?
    
    var wrappedBrewery: Brewery {
        return Brewery(id: Int(id),
                       name: name ?? "-",
                       breweryType: breweryType,
                       street: street,
                       address2: address2,
                       address3: address3,
                       city: city,
                       state: state,
                       countyProvince: countyProvince,
                       postalCode: postalCode,
                       country: country,
                       longitude: longitude,
                       latitude: latitude,
                       phone: phone,
                       websiteURL: websiteURL,
                       updatedAt: updatedAt)
    }
    
    func fillWith(brewery: Brewery) {
        self.id = Int16(brewery.id)
        self.name = brewery.name
        self.breweryType = brewery.breweryType
        self.street = brewery.street
        self.address2 = brewery.address2
        self.address3 = brewery.address3
        self.city = brewery.city
        self.state = brewery.state
        self.countyProvince = brewery.countyProvince
        self.postalCode = brewery.postalCode
        self.country = brewery.country
        self.longitude = brewery.longitude
        self.latitude = brewery.latitude
        self.phone = brewery.phone
        self.websiteURL = brewery.websiteURL
        self.updatedAt = brewery.updatedAt
    }

}
