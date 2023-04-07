//
//  MainView.swift
//  HW72
//
//  Created by Abinaya on 3/21/23.
//

import SwiftUI
import PhotosUI
import Firebase
struct MainView: View {
    let database = Firestore.firestore()
    @State var allSpots = [String]()
    
    //TODO: create and implement the function readAll() as shown in the slides.
    // take a peek at FirestoreManager.swift, specifically lines 24-27 for reference on what variables we have


    var body: some View {
        ZStack {
            Image("firecracker")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                ForEach(allSpots, id: \.self) { spot in
                    Text(spot).font(.title2)
                    Divider()
                }
            }.padding(.top, 30).onAppear {
                //TODO: call the readAll function here
        }
        }

    }
}
