//
//  OffreData.swift
//  AutoHire
//
//  Created by Admin on 12/2/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import Foundation
struct OffreData: Codable {
    
    var customer_id: Int
    var customer_name: String
    var customer_type: String
    var age: Int
    var units_sold: Int
}
