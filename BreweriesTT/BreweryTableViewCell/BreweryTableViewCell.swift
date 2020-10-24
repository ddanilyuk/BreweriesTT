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
            phoneLabel.text = brewery.phone
            countryLabel.text = brewery.country
            cityLabel.text = brewery.city
            streetLabel.text = brewery.street
            
            if brewery.websiteURL.isEmpty {
                mainStackView.removeArrangedSubview(websiteStackView)
                websiteStackView.isHidden = true
                
            } else {
                let websiteAttributedText = NSMutableAttributedString(string: brewery.websiteURL, attributes: [
                    NSAttributedString.Key.font : UIFont.iowanOldStyle.roman.font(size: 13),
                    NSAttributedString.Key.foregroundColor : UIColor.black.cgColor,
                    NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
                ])
                websiteButton.setAttributedTitle(websiteAttributedText, for: .normal)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
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

        
        mapButton.layer.cornerRadius = 8
                
        cardView.layer.cornerRadius = 20
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor(named: "MainColor")?.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func didPressShowWebsite(_ sender: UIButton) {
        if let url = URL(string: brewery?.websiteURL ?? "") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            UIApplication.shared.statusBarUIView?.backgroundColor = UIColor.clear

            self.window?.rootViewController?.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func didPressShowOnMap(_ sender: UIButton) {
        guard let brewery = brewery else { return }
        let location = CLLocation(latitude: Double(brewery.latitude) ?? 0, longitude: Double(brewery.longitude) ?? 0)
        guard let mapVC = MapViewNavigationController.instantiateMapViewControllerWithNavigation(with: location, name: brewery.name) else { return }
        mapVC.modalPresentationStyle = .formSheet
        
        self.window?.rootViewController?.present(mapVC, animated: true, completion: nil)
    }
    
}
