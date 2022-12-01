//
//  OrderInfoView.swift
//  MeHungi
//
//  Created by Aaron McCully on 11/30/22.
//

import SwiftUI

struct OrderInfoView : View {
    
    @ObservedObject var orderData = OrderData.orderData
    @State var timer : Timer?
    @State var showOrderReadyScreen = false
    
    var body: some View {
        
        ZStack {
            Color(UIColor.systemIndigo)
                .edgesIgnoringSafeArea(.top)
            if !showOrderReadyScreen {
                VStack {
                    Image(systemName: orderData.hasOrder ? "timer" : "circle.slash")
                        .font(.system(size: 125))
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                    Text(orderData.hasOrder ? "Estimated finish\ntime ~ \(orderData.estimatedFinishTime)" : "You don't have an\norder currently")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                    if orderData.hasOrder {
                        Text("Your order from \(orderData.currentOrder)")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                            .padding(.top, 10)
                            .frame(maxWidth: 200)
                    }
                }
                .padding(.bottom, 100)
            }
            else {
                VStack {
                    Image(systemName: "checkmark.circle")
                        .font(.system(size: 125))
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                    Text("Your order is ready!")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                }
                .padding(.bottom, 100)
            }
        }
        .onAppear {
            if orderData.hasOrder {
                print("Seeing if order is ready...")
                Task {
                    if (await checkOrderIsReady()) {
                        orderData.hasOrder = false
                        orderData.currentOrder = ""
                        orderData.estimatedFinishTime = ""
                        showOrderReadyScreen = true
                    }
                }
            
                // currently checks every 5 seconds
                timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
                    print("Seeing if order is ready...")
                    Task{
                        if (await checkOrderIsReady()) {
                            orderData.hasOrder = false
                            orderData.currentOrder = ""
                            orderData.estimatedFinishTime = ""
                            showOrderReadyScreen = true
                            timer?.invalidate()
                        }
                    }
                })
            }
        }
        .onDisappear {
            timer?.invalidate()
            showOrderReadyScreen = false
        }
    }
}

func checkOrderIsReady() async -> Bool {
    // code here for making request to see if order is ready
    // return TRUE when order is ready
    
    let url: URL = URL(string: "http://127.0.0.1:5000/restaurant/" + OrderData.orderData.restID + "/orders/" + OrderData.orderData.orderId)!
    
    var toReturn: Bool = false
    
    do {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw RestaurantError.HTTPRequestError
        }
        
        let dic = try JSONDecoder().decode([String:Bool].self, from: data)
        
        print(dic)
        
        toReturn = dic["Order Exists"]!
    }
    catch {
        print(error)
        toReturn = true
    }
    return toReturn ? false : true
}

struct OrderInfoView_Previews : PreviewProvider {
    static var previews: some View {
        OrderInfoView()
    }
}


