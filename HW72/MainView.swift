//
//  MainView.swift
//  HW72
//
//  Created by Abinaya on 3/21/23.
//

import SwiftUI
import PhotosUI

struct MainView: View {
    @State var selectedLocation = ""
    @State var restaurantName = ""
    @State var rating = 0
    @State private var showingImagePicker = false
    
    let locations = ["North", "South", "Uphill", "South Berkeley", "Elmwood"]

    func updateObj() {
        let firestoreObj = FirestoreManager()
        firestoreObj.create(selectedLocation: selectedLocation, restaurantName: restaurantName, rating: rating)
    }
    
    var body: some View {
        VStack {
            Text("Add a spot").font(.title)
            TextField("Kimchi Garden", text: $restaurantName).frame(alignment: .center).padding(.leading, 50).padding(.trailing, 50).font(.body).multilineTextAlignment(.center)
            VStack {
                Picker("Select a location", selection: $selectedLocation) {
                    ForEach(locations, id: \.self) {
                        Text($0).frame(alignment: .center).font(.body)
                    }
                }
            }.pickerStyle(.menu)
            TextField("How much did you enjoy it out of 10?", value: $rating, format: .number).font(.body).multilineTextAlignment(.center)
            
            Button(action: {updateObj()}) {
                Text("Save")            }
        }.background(
            Image("grass")
                .resizable()
        )
    }
}
