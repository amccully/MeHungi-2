//
//  ContentView.swift
//  MeHungi
//
//  Created by Aaron McCully on 10/27/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ModelData
    
    var body: some View {
        NavigationView {
            List(model.restaurants) { restaurant in
                NavigationLink(destination: EmptyView()) {
                    HStack {
                        Text(restaurant.name)
                        Spacer()
                        Text("\(restaurant.waitTime) mins")
                    }
                }
            }
            .navigationTitle("MeHungi")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
