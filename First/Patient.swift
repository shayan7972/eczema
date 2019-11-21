//
//  Patient.swift
//  First
//
//  Created by Shayan on 2019-11-01.
//  Copyright © 2019 Eczema. All rights reserved.
//

import UIKit
import os.log

class Patient: NSObject, NSCoding {
    
    

    
    
    //MARK: Properties
    
    var name: String
    var age: Int
    var photo: UIImage?
    
    //MARK: Archiving Paths
     
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("patients")
    
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let age = "age"
    }
    
    init?(name: String, photo: UIImage?, age: Int) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || age < 0  {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.age = age
        
    }
    
    override init() {
        name = "baby"
        age = 1
    }
    
    //MARK: NSCoding
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: PropertyKey.name)
        coder.encode(photo, forKey: PropertyKey.photo)
        coder.encode(age, forKey: PropertyKey.age)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let age = aDecoder.decodeInteger(forKey: PropertyKey.age)
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, age: age)
    }
    
    
}


