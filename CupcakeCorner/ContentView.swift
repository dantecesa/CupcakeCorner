//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Dante Cesa on 1/28/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("🧑🏻‍🍳 Flavor", selection: $order.type) {
                        ForEach(0..<Order.types.count) { index in
                            Text(Order.types[index])
                        }
                    }
                    
                    Stepper("# of 🧁s: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("🙇🏻‍♂️ Special Request?", isOn: $order.specialRequestEnabled.animation())
                }
                
                if order.specialRequestEnabled {
                    Section {
                        Toggle("❄️ Extra Frosting?", isOn: $order.extraFrosting)
                        
                        Toggle("✨ Add Sprinkles?", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
