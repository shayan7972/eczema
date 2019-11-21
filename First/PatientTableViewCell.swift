//
//  PatientTableViewCell.swift
//  First
//
//  Created by Shayan on 2019-11-02.
//  Copyright © 2019 Eczema. All rights reserved.
//

import UIKit

class PatientTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
