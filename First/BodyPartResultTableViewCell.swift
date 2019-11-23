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
    
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var medic: UILabel!
    
    @IBOutlet weak var statusCircle: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    func setEverything(bodypart: BodyPart, sev: String ){
        body = bodypart
        self.severity = sev
        fillProgressBar()
        iconImage.image = body?.icon
        let prescription = Prescription(severity: sev, bodypart: bodypart.name)
        medications = prescription.medications
        writeInMedications()
    }
    
    func setEverythingGeneral(int: Int){
        let prescription = Prescription()
        medications.removeAll()
        medications.append(prescription.medications[int])
        if (int == 0){
            iconImage.image = UIImage(named: "bathtub")
        }
        else if (int == 1){
            iconImage.image = UIImage(named: "ointment")
        }
        statusLabel.text = medications[0].title
        statusCircle.backgroundColor = UIColor.white
        medic.text = medications[0].frequency
    }
    
    func writeInMedications(){
        medic.text = ""
        for m in medications{
            medic.text! += m.title + ": " + m.frequency + "\n"
        }
        medic.numberOfLines = medications.count
    }
    
    
    func fillProgressBar(){
        if (severity == "0_nomral"){
            statusLabel.text = "Clear"
            statusCircle.backgroundColor = UIColor.green
        }
        else if (severity == "1_mild"){
            statusLabel.text = "Under Control"
            statusCircle.backgroundColor = UIColor.yellow
        }
        else if (severity == "2_moderate"){
            statusLabel.text = "Flare Up"
            statusCircle.backgroundColor = UIColor.orange
            
        }
        else if (severity == "3_severe"){
            statusLabel.text = "Out of Control"
            statusCircle.backgroundColor = UIColor.red
            
        }
        else if (severity == "no-skin-detected"){
            statusLabel.text = "No Skin Detected"
            statusCircle.backgroundColor = UIColor.gray
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
