//
//  ViewModel.swift
//  Capstone4
//
//  Created by Maria Silva on 2/1/23.
//

import Foundation
import Firebase


class ViewModel: ObservableObject {
    @Published var weeks = [Week]()
    
    func addData(title: String, completed: Bool, size: String) {
        let db = Firestore.firestore()
        db.collection("week").addDocument(data: ["title": title, "completed": false, "size": size]) { error in
            if error == nil {
                self.getData()
            }
            else {
                print("Error adding week")
            }
        }
    }
    
    func getData() {
        let db = Firestore.firestore()
        db.collection("week").addSnapshotListener { (querySnapshot, error) in
            guard let document = querySnapshot?.documents else {
                print("No documet")
                return
            }
            self.weeks = document.map { document in
                return Week(id: document.documentID, title: document["title"] as? String ?? "", completed: document["completed"] as? Bool ?? false, labs: document["labs"] as? Array ?? [], size: document["size"] as? String ?? "")
            }
        }
        
    }
    func updateData(weekToUpdate: Week) {
        let db = Firestore.firestore()
        db.collection("week").document(weekToUpdate.id).setData(["completed": true], merge: true) { error in
            if error == nil {
                self.getData()
            }
            else {
                print("Error updating week to true")
            }
        }
    }
    
    func updateDataFalse(weekToUpdate: Week) {
        let db = Firestore.firestore()
        db.collection("week").document(weekToUpdate.id).setData(["completed": false], merge: true) { error in
            if error == nil {
                self.getData()
            }
            else {
                print("Error updating week to false")
            }
        }
    }
    
    func deleteData(weekToDelete: Week) {
        let db = Firestore.firestore()
        db.collection("week").document(weekToDelete.id).delete { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.weeks.removeAll { week in
                        return week.id == weekToDelete.id
                    }
                }
            }
            else {
                print("Error deleting week")
            }
            
        }
    }
}
