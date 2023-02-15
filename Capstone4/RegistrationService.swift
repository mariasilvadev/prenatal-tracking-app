//
//  RegistrationService.swift
//  Capstone4
//
//  Created by Maria Silva on 2/9/23.
//

import Foundation
import Firebase

class RegistrationService: ObservableObject {
    @Published var users = [User]()
    
    func addUser(id: String, email: String, name: String, password: String, twitter: String, site: String, selectedDueDate: Date) {
        let db = Firestore.firestore()
        db.collection("users").addDocument(data: ["id": id, "email": email, "name": name, "password": password, "twitter": twitter, "site": site, "selectedDueDate": selectedDueDate]) { error in
            if error == nil {
                self.getUsers()
            }
            else {
                print("Error adding user")
            }
        }
    }
    
    func getUsers() {
        let db = Firestore.firestore()
        db.collection("user").addSnapshotListener { (querySnapshot, error) in
            guard let document = querySnapshot?.documents else {
                print("No documet")
                return
            }
            self.users = document.map { document in
                return User(id: document.documentID, email: document["email"] as? String ?? "", password: document["password"] as? String ?? "", name: document["name"] as? String ?? "", twitter: document["twitter"] as? String ?? "", site: document["site"] as? String ?? "", selectedDueDate: document["selectedDueDate"] as? Date ?? .now)
            }
        }
        
    }
    
    func deleteUser(userToDelete: User) {
        let db = Firestore.firestore()
        db.collection("users").document(userToDelete.id).delete { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.users.removeAll { user in
                        return user.id == userToDelete.id
                    }
                }
            }
            else {
                print("Error deleting user")
            }
            
        }
    }
}
