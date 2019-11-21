//
//  BodyPart.swift
//  First
//
//  Created by Shayan on 2019-11-10.
//  Copyright © 2019 Eczema. All rights reserved.
//

import Foundation
import UIKit


class BodyPart{

    
    var name: String
    var icon: UIImage
    var photo: UIImage? = UIImage(named: "picture")
    
    init(name: String) {
        self.name = name
        self.icon = UIImage(named: name + "-Checked")!
    }
}
