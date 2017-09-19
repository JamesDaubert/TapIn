//
//  Address.swift
//  TapIn
//
//  Created by James Daubert on 8/7/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

class Address {
    let number: Int
    let streetName: String
    let city: String
    let zip: String
    let state: String
    
    init(number: Int, streetName: String, city: String, zip: String, state: String) {
        self.number = number
        self.streetName = streetName
        self.city = city
        self.zip = zip
        self.state = state
    }
}
