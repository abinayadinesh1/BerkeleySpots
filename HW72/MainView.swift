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
    
    func readAll(db: Firestore) {
        let ref = db.collection("Locations")
        ref.getDocuments {snapshot, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            if let snap = snapshot {
                for doc in snap.documents {

                    let data = doc.data()
                    let restaurantName = data["restaurant name"] as? String ?? ""
                    let location = data["selected location"] as? String ?? ""
                    let rating = data["rating"] as? String ?? ""
                    
                    allSpots.append("Restaurant Name: \(restaurantName) \n Location: \(location) \n Rating: \(rating)")
                }
            }
        }
    }


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
                readAll(db: database)
        }
        }

    }
}
