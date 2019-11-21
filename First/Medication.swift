//
//  Medication.swift
//  First
//
//  Created by Shayan on 2019-11-12.
//  Copyright © 2019 Eczema. All rights reserved.
//

import Foundation
import UIKit

class Medication {
    var title: String
    var frequency: String
    var duration: String?
    var type: String?
    var dose: Double?
    
    init(title: String, freq: String) {
        self.title = title
        self.frequency = freq
    }
    
    init(title: String, freq: String, dose: Double, type: String) {
        self.title = title
        self.frequency = freq
        self.dose = dose
        self.type = type
    }
}
