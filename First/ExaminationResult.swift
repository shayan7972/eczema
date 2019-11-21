//
//  ExaminationResult.swift
//  First
//
//  Created by Shayan on 2019-11-12.
//  Copyright © 2019 Eczema. All rights reserved.
//

import Foundation
import UIKit

class ExaminationResult{
    
    var baby: Patient
    var date: Date
    var bodypart : BodyPart
    var severity: String
    var prescription: Prescription
    
    init(baby: Patient, severity: String, bodypart: String) {
        self.baby = baby
        date = Date.init()
        self.severity = severity
        self.bodypart = BodyPart(name: bodypart)
        self.prescription = Prescription(severity: severity, bodypart: bodypart)
    }
}
