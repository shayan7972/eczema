//
//  Prescription.swift
//  First
//
//  Created by Shayan on 2019-11-12.
//  Copyright © 2019 Eczema. All rights reserved.
//

import Foundation
import UIKit

class Prescription{
    var medications = [Medication]()
    
    let body1 = ["face","neck","armpit","groin"]
    let body2 = ["arm","leg","hand","foot","torso"]
    
    let denso = Medication(title: "Densonide", freq: "two times a day",dose: 0.05,type: "ointment")
    let proto = Medication(title: "Protopic", freq: "two times a day",dose: 0.1,type: "ointment")
    let betha = Medication(title: "Bethamethasone", freq: "two times a day",dose: 0.1,type: "ointment")
    let clob = Medication(title: "Clobetasol", freq: "two times a day",dose: 0.05,type: "ointment")
//    let hydro = Medication(title: "Hydroxyzine", freq: "bed time",dose: 1,type: "solution")
    let bath = Medication(title: "bath", freq: "daily")
    let moist = Medication(title: "apply moist cream", freq: "two times a day")
    
    // General Prescription
    init(){
        bath.duration = "10 mins"
        moist.type = "cream"
        medications.append(bath)
        medications.append(moist)

    }

    
    // 
    init(severity: String, bodypart: String) {
        if(severity=="under-control"){
            
        }
        else if (severity == "flare-up"){
            if (body1.contains(bodypart)){
                medications.append(denso)
                medications.append(proto)
            }
            else if (body2.contains(bodypart)){
                medications.append(denso)
                medications.append(proto)
                medications.append(betha)
            }
            
        }
        else if (severity == "out-of-control"){
            if (body1.contains(bodypart)){
                betha.duration = "No more than 14 out of 21 days"
                medications.append(betha)
            }
            else if (body2.contains(bodypart)){
                clob.duration = "No more than 7 out of 14 days"
                medications.append(clob)
            }
        }
    }
}
