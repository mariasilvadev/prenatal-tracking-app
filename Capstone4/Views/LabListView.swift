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
                .foregroundColor(Color("gold2"))
            
            List(week.labs, id: \.self) { lab in
                Text(lab)
                    .padding(5)
            }
            
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("pink4"))
    }
}


struct LabListView_Previews: PreviewProvider {
    static var previews: some View {
        LabListView(week: Week(id: "", title: "title", completed: false, labs: ["lab 1", "lab 2", "lab 3"], size: "banana"))
    }
}

//import SwiftUI
//import Firebase
//
//struct LabListView: View {
//    let week: Week
//
//    var body: some View {
//            VStack(spacing: 20) {
//                Text("What you can expect")
//                    .font(.title)
//                    .padding(.horizontal)
//                    .foregroundColor(Color("gold2"))
//                List(week.labs, id: \.self) { lab in
//                    VStack {
//                        Text(lab)
//                    }
//
//                }
//                .background(Color("pink4"))
//                .scrollContentBackground(.hidden)
//                Spacer()
//
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color("pink4"))
//    }
//}
//
//
//struct LabListView_Previews: PreviewProvider {
//    static var previews: some View {
//        LabListView(week: Week(id: "", title: "title", completed: false, labs: ["lab 1", "lab 2", "lab 3"], size: "banana"))
//    }
//}
