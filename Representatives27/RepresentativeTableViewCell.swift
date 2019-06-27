//
//  RepresentativeTableViewCell.swift
//  Representatives27
//
//  Created by Albert Yu on 6/27/19.
//  Copyright © 2019 AlbertLLC. All rights reserved.
//

import UIKit

class RepresentativeTableViewCell: UITableViewCell {

    var representative: Representative? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var representativeNameLabel: UILabel!
    @IBOutlet weak var representativeTitleLabel: UILabel!
    @IBOutlet weak var representativeWebsiteLabel: UILabel!
    @IBOutlet weak var representativeDistrictLabel: UILabel!
    @IBOutlet weak var representativeDistrictPhoneNumberButton: UIButton!
    
 
    func updateViews() {
        guard let representative = representative else {return}
        self.representativeNameLabel.text = representative.name
        self.representativeTitleLabel.text = representative.party
        self.representativeWebsiteLabel.text = representative.link
        self.representativeDistrictLabel.text = representative.district
        self.representativeDistrictPhoneNumberButton.setTitle(representative.phone, for: .normal)

    }
    @IBAction func phoneNumberTapped(_ sender: UIButton) {
        guard let representative = representative else {return}
        if let phoneURL = URL(string: "tel://\(representative.phone)") {
            UIApplication.shared.canOpenURL(phoneURL)
            UIApplication.shared.open(phoneURL)
        }
    }
    
}
