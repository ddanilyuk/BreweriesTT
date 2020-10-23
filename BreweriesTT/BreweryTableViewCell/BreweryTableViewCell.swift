//
//  BreweryTableViewCell.swift
//  BreweriesTT
//
//  Created by Денис Данилюк on 23.10.2020.
//

import UIKit

class BreweryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet weak var phoneStackView: UIStackView!
    @IBOutlet weak var websiteStackView: UIStackView!
    @IBOutlet weak var countryStackView: UIStackView!
    @IBOutlet weak var cityStackView: UIStackView!
    @IBOutlet weak var streetStackView: UIStackView!
    
    
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
            } else {
                websiteButton.setTitle(brewery.websiteURL, for: .normal)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
