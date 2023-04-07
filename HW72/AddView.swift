//
//  MainView.swift
//  HW72
//
//  Created by Abinaya on 3/21/23.
//

import SwiftUI
import PhotosUI

struct AddView: View {
    @State var selectedLocation = ""
    @State var restaurantName = ""
    @State var showAlert = false
    
    let locations = ["North", "South", "Uphill", "South Berkeley", "Elmwood"]

    func updateObj() {
        let firestoreObj = FirestoreManager()
        // TODO: create a new Firestore Object (1 line)
        showAlert = true
    }

    func clearFields() {
        //TODO: reset the inputted values within this function (2 lines)
        showAlert = false
    }
    
    var body: some View {
        ZStack {
            Image("grass")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Add a spot").font(.title)
                Divider().background(Color.white)
                TextField("Kimchi Garden", text: $restaurantName).frame(alignment: .center).padding(.leading, 50).padding(.trailing, 50).font(.title2).multilineTextAlignment(.center)
                VStack {
                    Picker("Select a location", selection: $selectedLocation) {
                        ForEach(locations, id: \.self) {
                            Text($0).frame(alignment: .center).font(.title2)
                        }
                    }.scaleEffect(1.5)
                }.pickerStyle(.menu)
                    Button(action: {updateObj()}) {
                        Text("Save")}.background(.blue).font(.title3)
                    .frame(width: 70, height: 30).cornerRadius(10).alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Spot posted!"),
                                dismissButton: .default(Text("Close"), action: {
                                    showAlert = false
                                    clearFields()
                                })
                            )
                        }
            }.foregroundColor(.black)

        }
    }
}
