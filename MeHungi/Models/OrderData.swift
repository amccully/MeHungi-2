//
//  OrderData.swift
//  MeHungi
//
//  Created by Aaron McCully on 11/30/22.
//

import Foundation

class OrderData: ObservableObject {
    
    public static var orderData = OrderData()
    
    @Published var hasOrder = false
    @Published var currentOrder = ""
    @Published var estimatedFinishTime = ""
    @Published var orderId = ""
    @Published var restID = ""
    @Published var long = 0.0
    @Published var lat = 0.0
}
