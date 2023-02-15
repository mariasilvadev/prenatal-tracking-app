//
//  LabListView.swift
//  Capstone4
//
//  Created by Maria Silva on 2/2/23.
//

import SwiftUI
import Firebase

struct LabListView: View {
    let week: Week

    var body: some View {
            VStack(spacing: 20) {
                Text("What you can expect")
                    .font(.title)
                    .padding(.horizontal)
                List(week.labs, id: \.self) { lab in
                    VStack {
                        Text(lab)
                    }
                }
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.569, green: 0.902, blue: 0.928))
    }
}


struct LabListView_Previews: PreviewProvider {
    static var previews: some View {
        LabListView(week: Week(id: "", title: "title", completed: false, labs: ["lab 1", "lab 2", "lab 3"], size: "banana"))
    }
}
