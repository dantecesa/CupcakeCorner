//
//  OrderViewModel.swift
//  CupcakeCorner
//
//  Created by Dante Cesa on 2/1/22.
//

import Foundation

class OrderViewModel: ObservableObject {
    @Published var currentOrder: Order = Order()
    
}
