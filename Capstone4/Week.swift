//
//  Item.swift
//  Capstone4
//
//  Created by Maria Silva on 2/1/23.
//

import Foundation

struct Week: Identifiable, Codable {
    var id: String
    var title: String
    var completed: Bool
    var labs = [String]()
    var size: String
}
