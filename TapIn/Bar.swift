//
//  Bar.swift
//  TapIn
//
//  Created by James Daubert on 8/7/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

class Bar {
    let menu: Dictionary<String, Any>
    let address: Address
    
    
    init(menu: Dictionary<String, Any>, address: Address) {
        self.menu = menu
        self.address = address
    }
}
