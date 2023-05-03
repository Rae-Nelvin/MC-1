//
//  PlayerExtension.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 02/05/23.
//

import Foundation
import CoreData

extension Player {
    func toDictionary() -> [String: Any] {
        return ["name": name, "dob": dob, "frequency": frequency, "smokerFor": smokerFor, "typeOfCigarattes": typeOfCigarattes]
    }
}
