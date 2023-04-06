//
//  FirestoreManager.swift
//  HW72
//
//  Created by Abinaya on 3/21/23.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit
import SwiftUI


class FirestoreManager: ObservableObject {
    // Today, we'll finish our implenentation of CRUS with -UD! You'll see the solutions for CR- already here.
    
    let db = Firestore.firestore() //make a new database instance
    let storage = Storage.storage() //make a new storage instance - only needed for images!
    
    func create(selectedLocation: String, restaurantName: String, rating: Int, image: UIImage) {
        
        // format our data as a list
        let docData: [String: Any] = [
            "selected location": selectedLocation,
            "restaurant name": restaurantName,
            "rating": rating,
        ]
        
        // specify the collection we would like to populate. every time we add a new 'spot', we want to add to this collection.
        let locations_collection = db.collection("Locations")
        
        //make an id for the object; this could be anything unique to the data (like the restaurant name), but since two people can make two entries for the same restaurant name, we are using UUID to generate a unique id
        let id: String = UUID().uuidString
            
        //use the firebase .setData function to upload our docData into the specified collection
        // catch any errors that may be found in the result
        locations_collection.document(id).setData(docData) {error in
            if let error = error {
                print("Error writing document \(error)")
            } else {
                print("Document successfully written!")
            }
        }
        
        // IMAGE STUFF
        let imageData: Data = image.jpegData(compressionQuality: 0.2)!
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        let ref = storage.reference().child("images/image.jpg")


        ref.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                print("Error uploading image \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }


    
    func read(docID: String){
        let db = Firestore.firestore()
        // define the collection you want to read from
        let locations_collection = db.collection("Locations")
        let location_doc = locations_collection.document(docID) // specify a document here
        location_doc.getDocument {(document, error) in
            if let document = document, document.exists {
                let document = document.data() ?? [:]
                print(document.description)
            } else {
                print("document does not exist")
            }
        }
        // use the right function to get a swift dictionary of our data
    }
    
    
    
    //TODO: use the example in the slides to make a function that gets a snapshot of all the data in our collection and iterates through that data
//        .listAll?
    
}
