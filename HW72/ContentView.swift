//
//  ContentView.swift
//  HW72
//
//  Created by Abinaya on 3/21/23.
//

import SwiftUI
import Firebase
import FirebaseCore

struct ContentView: View {
    init() {
           FirebaseApp.configure()
       }
    
    var body: some View {
        TabView {
            AddView().tabItem {
                Label("Add New Spot", systemImage: "plus.circle")
            }
            MainView().tabItem {
                Label("Spots", systemImage: "takeoutbag.and.cup.and.straw.fill")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
