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
    @State var email = ""
    @State var password = ""
    @State var loggedIn = true
    
    
    init() {
        FirebaseApp.configure()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                loggedIn = true
                print("success")
            }
        }
    }

    var body: some View {
        if loggedIn {
            MainView()
        } else {
            TextField("Email", text: $email).textFieldStyle(.roundedBorder).multilineTextAlignment(.center)
            TextField("Password", text: $password).textFieldStyle(.roundedBorder).multilineTextAlignment(.center)
                
            Button(action: { login() }){
                     Text("Sign in")
                 }.buttonStyle(. bordered).tint(.mint)
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
