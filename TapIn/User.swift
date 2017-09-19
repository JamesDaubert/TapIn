//
//  User.swift
//  TapIn
//
//  Created by James Daubert on 8/7/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

import Firebase
import FirebaseDatabase
import CoreLocation

class User {
    let name: String
    let profilePicture: UIImage
    let location: CLLocation
    let tapStatus: Bool
    let atBar: Bar? 
    
    init(name: String, profilePicture: UIImage, location: CLLocation, tapStatus: Bool, atBar: Bar){
        self.name = name
        self.profilePicture = profilePicture
        self.location = location
        self.tapStatus = tapStatus
        self.atBar = atBar
        
    }
}

