//
//  BreweryTableViewCell.swift
//  BreweriesTT
//
//  Created by Денис Данилюк on 23.10.2020.
//

import UIKit
import SafariServices
import MapKit

class BreweryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var mapButton: UIButton!
    
    
    @IBOutlet weak var phonePlaceholderLabel: UILabel!
    @IBOutlet weak var websitePlaceholderLabel: UILabel!
    @IBOutlet weak var countryPlaceholderLabel: UILabel!
    @IBOutlet weak var cityPlaceholderLabel: UILabel!
    @IBOutlet weak var streetPlaceholderLabel: UILabel!
    
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet weak var phoneStackView: UIStackView!
    @IBOutlet weak var websiteStackView: UIStackView!
    @IBOutlet weak var countryStackView: UIStackView!
    @IBOutlet weak var cityStackView: UIStackView!
    @IBOutlet weak var streetStackView: UIStackView!
    @IBOutlet weak var mapStackView: UIStackView!
    
    
    @IBOutlet weak var cardView: UIView!
    
    
    public var brewery: Brewery? {
        didSet {
            guard let brewery = brewery else { return }
            nameLabel.text = brewery.name
            
            if let phone = brewery.phone, !phone.isEmpty {
                phoneLabel.text = phone
            } else {
                mainStackView.removeArrangedSubview(phoneStackView)
                phoneStackView.isHidden = true
            }
            
            if let country = brewery.country, !country.isEmpty {
                countryLabel.text = country
            } else {
                mainStackView.removeArrangedSubview(countryStackView)
                countryStackView.isHidden = true
            }
            
            if let city = brewery.city, !city.isEmpty {
                cityLabel.text = city
            } else {
                mainStackView.removeArrangedSubview(cityStackView)
                cityStackView.isHidden = true
            }
            
            if let street = brewery.street, !street.isEmpty {
                streetLabel.text = street
            } else {
                mainStackView.removeArrangedSubview(streetStackView)
                streetStackView.isHidden = true
            }
            
            if let latitude = brewery.latitude, let longitude = brewery.longitude, !latitude.isEmpty, !longitude.isEmpty {
                
            } else {
                mainStackView.removeArrangedSubview(mapStackView)
                mapStackView.isHidden = true
            }
            
            if let websiteURL = brewery.websiteURL, !websiteURL.isEmpty {
                let websiteAttributedText = NSMutableAttributedString(string: brewery.websiteURL!, attributes: [
                    NSAttributedString.Key.font : UIFont.iowanOldStyle.roman.font(size: 13),
                    NSAttributedString.Key.foregroundColor : UIColor.black.cgColor,
                    NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
                ])
                websiteButton.setAttributedTitle(websiteAttributedText, for: .normal)
            } else {
                mainStackView.removeArrangedSubview(websiteStackView)
                websiteStackView.isHidden = true
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set fonts
        nameLabel.font = UIFont.iowanOldStyle.bold.font(size: 20)
        nameLabel.textColor = UIColor(named: "BlackTextColor")
        
        phoneLabel.font = UIFont.iowanOldStyle.roman.font(size: 13)
        websiteButton.titleLabel?.font = UIFont.iowanOldStyle.roman.font(size: 13)
        mapButton.titleLabel?.font = UIFont.iowanOldStyle.roman.font(size: 13)
        countryLabel.font = UIFont.iowanOldStyle.roman.font(size: 13)
        cityLabel.font = UIFont.iowanOldStyle.roman.font(size: 13)
        streetLabel.font = UIFont.iowanOldStyle.roman.font(size: 13)
        phonePlaceholderLabel.font = UIFont.iowanOldStyle.roman.font(size: 13)
        websitePlaceholderLabel.font = UIFont.iowanOldStyle.roman.font(size: 13)
        countryPlaceholderLabel.font = UIFont.iowanOldStyle.roman.font(size: 13)
        cityPlaceholderLabel.font = UIFont.iowanOldStyle.roman.font(size: 13)
        streetPlaceholderLabel.font = UIFont.iowanOldStyle.roman.font(size: 13)
        
        // Edit apperance
        mapButton.layer.cornerRadius = 8
        cardView.layer.cornerRadius = 20
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor(named: "MainColor")?.cgColor
    }

    
    override func prepareForReuse() {
        // Remove all stacks and add them in the correct order
        let allStacks: [UIStackView] = [phoneStackView, websiteStackView, countryStackView, cityStackView, streetStackView, mapStackView]

        allStacks.forEach( { stackView in
            mainStackView.removeArrangedSubview(stackView)
        })
        
        allStacks.forEach( { stackView in
            mainStackView.addArrangedSubview(stackView)
            stackView.isHidden = false
        })

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Present SFSafariViewController
    @IBAction func didPressShowWebsite(_ sender: UIButton) {
        if let url = URL(string: brewery?.websiteURL ?? "") {
            let configuration = SFSafariViewController.Configuration()
            configuration.entersReaderIfAvailable = true
            let safariViewController = SFSafariViewController(url: url, configuration: configuration)
            self.window?.rootViewController?.present(safariViewController, animated: true, completion: nil)
        }
    }
    
    // Present MapViewController
    @IBAction func didPressShowOnMap(_ sender: UIButton) {
        guard let brewery = brewery else { return }
        let location = CLLocation(latitude: Double(brewery.latitude ?? "") ?? 0, longitude: Double(brewery.longitude ?? "") ?? 0)
        guard let mapViewController = MapViewNavigationController.instantiateMapViewControllerWithNavigation(with: location, name: brewery.name) else { return }
        mapViewController.modalPresentationStyle = .formSheet
        
        self.window?.rootViewController?.present(mapViewController, animated: true, completion: nil)
    }
    
}
