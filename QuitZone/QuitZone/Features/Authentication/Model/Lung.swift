//
//  Lung.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 21/04/23.
//

import Foundation
import CloudKit

struct Lung: Identifiable {
    var id = UUID()
    let images: LungCondition
}

enum LungCondition: String {
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
}
