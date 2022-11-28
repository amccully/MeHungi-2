//
//  OrderView.swift
//  MeHungi
//
//  Created by Aaron McCully on 11/25/22.
//

import SwiftUI

struct OrderView : View {
    
    @EnvironmentObject var model: ModelData
    @State var userOrderStr = ""
    @State var userOrderList = [String]()
    @State var showAlert = false
    let id: String
    var restaurant: Restaurant {
        model.restaurants[id]!
    }
    
    // Temporary:
    // @State var qty = 0
    // Change to determine how much of a given item a person can order. As of now, this is a single value that is the same across all menu items and restaurants
    // let maxQty = 5
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Text("Menu item:")
                        Spacer()
                        Text("Add to order:")
                    }
                    ForEach(restaurant.menuItems, id: \.self) { item in
                        HStack {
                            Text(item)
                            Spacer()
                            Button {
                                addToOrder(item: item)
                            } label: {
                                Image(systemName: "plus.rectangle")
                                    //.foregroundColor(.gray)
                                    .font(.title)
                            }
                        }
                    }
//                    ForEach(0..<restaurant.menuItems.count, id: \.self) { index in
//                        let item = restaurant.menuItems[index]
//                        HStack {
//                            Text(item)
//                            Spacer()
//                            Text("Qty: \(qty)")
//                            Stepper("Qty", value: $qtyList[index], in: 0...maxQty)
//                                .labelsHidden()
//                        }
//                    }
                }
                Section {
                    Text("Your order: \(userOrderStr)")
                    Button {
                       clearOrder()
                    } label: {
                        Text("Clear Order")
                            .foregroundColor(.red)
                    }
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
                        else if userOrderStr.isEmpty {
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
    
    func clearOrder() {
        userOrderList.removeAll()
        userOrderStr = ""
    }

    func addToOrder(item: String) {
        userOrderList.append(item)
        userOrderStr = orderListToString()
    }
    
    // probably not a great approach but works
    func orderListToString() -> String {
        var userStr = ""
        userOrderList.forEach { obj in
            userStr += "\(obj), "
        }
        userStr.removeLast(2)
        return userStr
    }
    
    func sendOrder() {
        // this will be a list containing all items of the order, use this in with api request
        // userOrderList
    }
}

//struct OrderView_Previews : PreviewProvider {
//    static var previews: some View {
//        OrderView(id: "001")
//    }
//}
