//
//  BodyPartResultTableViewCell.swift
//  First
//
//  Created by Shayan on 2019-11-12.
//  Copyright © 2019 Eczema. All rights reserved.
//

import UIKit

class BodyPartResultTableViewCell: UITableViewCell {
    
    var body : BodyPart?
    var severity : String?
    var medications = [Medication]()
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var medic: UILabel!
    
    func setEverything(bodypart: BodyPart, sev: String ){
        body = bodypart
        self.severity = sev
        fillProgressBar()
        iconImage.image = body?.icon
        let prescription = Prescription(severity: sev, bodypart: bodypart.name)
        medications = prescription.medications
        print(medications)
        writeInMedications()
    }
    
    func writeInMedications(){
        for m in medications{
            medic.text! += m.title + ":" + m.frequency + "\n"
        }
        medic.numberOfLines = medications.count - 1
    }
    
    
    func fillProgressBar(){
        if (severity == "under-control"){
            progressBar.progress = 0.3
            progressBar.progressTintColor = UIColor.green
        }
        else if (severity == "flare-up"){
            progressBar.progress = 0.6
            progressBar.progressTintColor = UIColor.yellow
            
        }
        else if (severity == "out-of-control"){
            progressBar.progress = 0.85
            progressBar.progressTintColor = UIColor.red
            
        }
        else if (severity == "no-skin-detected"){
            progressBar.progress = 0.1
            progressBar.progressTintColor = UIColor.gray
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
