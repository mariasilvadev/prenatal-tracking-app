//
//  RegistrationDetails.swift
//  Capstone4
//
//  Created by Maria Silva on 2/7/23.
//

import Foundation

struct User: Identifiable {
    var id: String
    var email: String
    var password: String
    var name: String
    var twitter: String
    var site: String
    var selectedDueDate: Date
    var selectedDueDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'of' MMMM"
        return formatter.string(from: selectedDueDate)
    }
}
