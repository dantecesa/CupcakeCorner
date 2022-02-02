//
//  Order.swift
//  CupcakeCorner
//
//  Created by Dante Cesa on 1/28/22.
//

import Foundation
import SwiftUI

struct Order: Codable {
    static let types: [String] = ["🍦 Vanilla", "🍓 Strawberry", "🍫 Chocolate", "🌈 Rainbow"]
    
    var type: Int = 0
    var quantity: Int = 3
    
    var specialRequestEnabled: Bool = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting: Bool = false
    var addSprinkles: Bool = false
    
    var name: String = ""
    var streetAddress: String = ""
    var city: String = ""
    var zip: String = ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || city.trimmingCharacters(in: .whitespaces).isEmpty || zip.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity * 2)
        
        // multiplier for complicated cakes
        cost += (Double(type) / 2)
        
        // +$1 for frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // +$.50 for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
