//
//  AddWeekView.swift
//  Capstone4
//
//  Created by Maria Silva on 2/3/23.
//

import SwiftUI

struct AddWeekView: View {
    @State private var title: String = ""
    @State private var size: String = ""
    @ObservedObject var model = ViewModel()
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Create a new visit")
                .font(.title2).bold()
                .frame(maxWidth: .infinity)
                .foregroundColor(Color("gold2"))
            
            Text("Enter the week of this visit:")
                .foregroundColor(Color("gold2"))
            TextField("Ex: Week 21", text: $title)
                .textFieldStyle(.roundedBorder)
            Text("Enter the size or lenght of your baby:")
                .foregroundColor(Color("gold2"))
            TextField("Ex: This week baby is the size of banana 🍌", text: $size)
                .textFieldStyle(.roundedBorder)
        
            Button {
                if title != "" {
                    model.addData(title: title, completed: false, size: size)
                }
                dismiss()
            } label: {
                Text("Add visit")
                    .foregroundColor(Color("gold2"))
                    .padding()
                    .background(Color("Color"))
                    .cornerRadius(30)
                    .fontWeight(.bold)
            }
            Spacer()
        }
        .padding(.top, 40)
        .padding(.horizontal)
        .background(Color("pink"))
    }
}

struct AddWeekView_Previews: PreviewProvider {
    static var previews: some View {
        AddWeekView()
    }
}
