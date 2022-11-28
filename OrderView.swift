//
//  OrderView.swift
//  MeHungi
//
//  Created by Aaron McCully on 11/25/22.
//

import SwiftUI

struct OrderView : View {
    
    @EnvironmentObject var model: ModelData
    
    @State var showAlert = false
    
    // Temporary
    @State var qty = 0
    //

    let id: String
    
    // Change to determine how much of a given item a person can order. As of now, this is a single value that is the same across all menu items and restaurants
    let maxQty = 5

    var restaurant: Restaurant {
        model.restaurants[id]!
    }
    
    var qtyList: [Int] {
        [Int](repeating: 0, count: restaurant.menuItems.count)
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(restaurant.menuItems, id: \.self) { item in
                        HStack {
                            Text(item)
                            Spacer()
                            Text("Qty: \(qty)")
                            Stepper("Qty", value: $qty, in: 0...maxQty)
                                .labelsHidden()
                        }
                    }
                }
                Section {
                    Button {
                        showAlert.toggle()
                    } label: {
                        Text("Place Order")
                            .foregroundColor(Color.blue)
                    }
                    .alert(isPresented: $showAlert) {
                        if !restaurant.isOpen {
                            return Alert(
                                title: Text("\(restaurant.name) is closed")
                            )
                        }
                        else if qty == 0 {
                            return Alert(
                                title: Text("Please add items to your order")
                            )
                        }
                        else {
                            return Alert(
                                title: Text("Confirm order?"),
                                primaryButton: .default(
                                    Text("Yes"),
                                    action: sendOrder
                                ),
                                secondaryButton: .destructive(
                                    Text("Cancel")
                                )
                            )
                        }
                    }
                }
            }
            .navigationTitle(restaurant.name)
        }
    }
}

struct OrderView_Previews : PreviewProvider {
    static var previews: some View {
        OrderView(id: "001")
    }
}

func sendOrder() {
    
}
