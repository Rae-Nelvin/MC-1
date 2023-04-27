//
//  UserModel.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import Foundation
import CloudKit

// Placeholder Delete Later
struct User {
    var name : String = "Leonardo Da Vinci"
    var dateOfBirth : String = "1 April 1050"
    var frequency : String = "Active"
    var smokerFor : String = "Not set"
    var typeOfCigarette : String = "Not set"
    var email : String = "Not set"
    var phone : String = "Not set"
    
    mutating func EditUser(name: String, dateOfBirth: String, frequency: String, smokerFor: String, typeOfCigarette: String, email: String, phone: String) {
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.frequency = frequency
        self.smokerFor = smokerFor
        self.typeOfCigarette = typeOfCigarette
        self.email = email
        self.phone = phone
    }
}
