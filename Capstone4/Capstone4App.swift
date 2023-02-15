//
//  Capstone4App.swift
//  Capstone4
//
//  Created by Maria Silva on 2/1/23.
//

import SwiftUI
import Firebase

@main
struct Capstone4App: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
