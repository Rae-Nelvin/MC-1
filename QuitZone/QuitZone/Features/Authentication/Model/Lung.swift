//
//  Lung.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 21/04/23.
//

import Foundation
import CloudKit

struct UserLung: Identifiable {
    var id = UUID()
    var userID: CKRecord.Reference
    var condition: LungCondition
    
    init(id: UUID = UUID(), userID: CKRecord.Reference, condition: LungCondition) {
        self.id = id
        self.userID = userID
        self.condition = condition
    }
    
    func toDictionary() -> [String: Any] {
        return ["userID": userID, "condition": condition]
    }
}

struct Lung: Identifiable {
    var id = UUID()
    let images: LungCondition
}

enum LungCondition: String {
    //    case healthy
    //    case slightlyBroken
    //    case broken
    //    case hardlyBroken
    //    case damaged
    case lv10 = "lunglvl10"
    case lv9 = "lunglvl9"
    case lv8 = "lunglvl8"
    case lv7 = "lunglvl7"
    case lv6 = "lunglvl6"
    case lv5 = "lunglvl5"
    case lv4 = "lunglvl4"
    case lv3 = "lunglvl3"
    case lv2 = "lunglvl2"
    case lv1 = "lunglvl1"
    
//    func LungImage() -> String {
//        switch self {
////        case .healthy:
////            <#code#>
////        case .slightlyBroken:
////            <#code#>
////        case .broken:
////            <#code#>
////        case .hardlyBroken:
////            <#code#>
////        case .damaged:
////            <#code#>
//        case .lv10:
//            return "lunglvl10"
//        case .lv9:
//            return "lunglvl9"
//        case .lv8:
//            return "lunglvl8"
//        case .lv7:
//            return "lunglvl7"
//        case .lv6:
//            return "lunglvl6"
//        case .lv5:
//            return "lunglvl5"
//        case .lv4:
//            return "lunglvl4"
//        case .lv3:
//            return "lunglvl3"
//        case .lv2:
//            return "lunglvl2"
//        case .lv1:
//            return "lunglvl1"
//        }
//    }
    
    
}
