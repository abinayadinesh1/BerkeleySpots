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
    @State private var inputImage = UIImage()
    
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
            
            VStack {
                Text("Add an image of your experience!")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(16)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .onTapGesture {
                        showingImagePicker = true
                    }
                Image(uiImage: self.inputImage)
                        .resizable()
                        .cornerRadius(10)
                        .padding(.all, 4)
                        .frame(width: 200, height: 200)
                        .background(Color.black.opacity(0.2))
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Rectangle())
                        .padding(.top, 10)
            }
            .padding(.horizontal, 20)
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$inputImage)
            }
            
            Button(action: {updateObj()}) {
                Text("Save")}
        }.background(
            Image("grass")
                .resizable()
        )
    }
}
