//
//  ButtonAddNew.swift
//  Capstone4
//
//  Created by Maria Silva on 2/3/23.
//

import SwiftUI

struct ButtonAddNew: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 50)
                .foregroundColor(Color("gold"))
            
            Text("+")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.white)
        }
        .frame(height: 50)
    }
}

struct ButtonAddNew_Previews: PreviewProvider {
    static var previews: some View {
        ButtonAddNew()
    }
}
