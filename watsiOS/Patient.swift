//
//  Patient.swift
//  watsiOS
//
//  Created by Nhi Quach on 4/8/16.
//  Copyright © 2016 bighack. All rights reserved.
//

import Foundation

class Patient {
    
    var token: String!
    
    var profileUrl: String!
    
    var age: Int!
    
    var ageTag: String!
    
    var name: String!
    
    var country: String!
    
    var target: Int!
    
    var donated: Int!
    
    var numberOfDonors: Int!
    
    var header: String!
    
    var partnerName : String!
    
    init(data: NSDictionary) {
        token = data.valueForKey("token") as! String
        profileUrl = data.valueForKey("photo_url") as! String

        if data.valueForKey("age_years") is NSNull {
            age = data.valueForKey("age_months") as! Int
            ageTag = "mo."
        } else {
            age = data.valueForKey("age_years") as! Int
            ageTag = ""
        }
        
        header = data.valueForKey("header") as! String
        partnerName = data.valueForKey("partner_name") as! String
        name = data.valueForKey("name") as! String
        country = data.valueForKey("country") as! String
        target = data.valueForKey("target_amount") as! Int
        numberOfDonors = data.valueForKey("number_of_donors") as! Int
        donated = data.valueForKey("amount_raised") as! Int
        
        
    }
    
}