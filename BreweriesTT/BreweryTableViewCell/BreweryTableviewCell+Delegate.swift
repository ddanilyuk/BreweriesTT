//
//  BreweryTableviewCell+Delegate.swift
//  BreweriesTT
//
//  Created by Денис Данилюк on 25.10.2020.
//

import Foundation

protocol BreweryTableViweCellDelegate: AnyObject {
    func didPressShowMap(with brewery: Brewery)
    func didPressOpenWebsite(with brewery: Brewery)
}
