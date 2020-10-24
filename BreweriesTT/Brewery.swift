//
//  Brewery.swift
//  BreweriesTT
//
//  Created by Денис Данилюк on 23.10.2020.
//

import Foundation


struct Brewery: Codable {
    let id: Int
    let name: String
    let breweryType: String?
    let street: String?
    let address2: String?
    let address3: String?
    let city: String?
    let state: String?
    let countyProvince: String?
    let postalCode: String?
    let country: String?
    let longitude: String?
    let latitude: String?
    let phone: String?
    let websiteURL: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case breweryType = "brewery_type"
        case street
        case address2 = "address_2"
        case address3 = "address_3"
        case city, state
        case countyProvince = "county_province"
        case postalCode = "postal_code"
        case country, longitude, latitude, phone
        case websiteURL = "website_url"
        case updatedAt = "updated_at"
    }
}
