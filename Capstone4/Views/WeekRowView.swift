//
//  WeekRowView.swift
//  Capstone4
//
//  Created by Maria Silva on 2/2/23.
//
import SwiftUI
import Firebase

struct WeeksRow: View {
    let week: Week

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 20) {
                Image(systemName: week.completed ? "checkmark.circle" : "circle")
                    .padding(.leading)
                    .font(.title)
                Text(week.title)
                    .font(.title3.bold())
            }
            .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
            .padding(.top)
            .foregroundColor(Color("gold2"))
                Text(week.size)
                    .frame(width: 280, height: 50, alignment: .leading)

        }
        .frame(maxWidth: .infinity, maxHeight: 150, alignment: .leading)
        .padding()
    }
}

struct WeeksRow_Previews: PreviewProvider {
    static var previews: some View {
        WeeksRow(week: Week(id: "", title: "title", completed: false, labs: ["lab 1", "lab 2", "lab 3"], size: "This week baby is about as long as a head of romaine lettuce 🥬"))
    }
}
