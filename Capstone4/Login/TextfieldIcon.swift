//
//  TextfieldIcon.swift
//  Capstone4
//
//  Created by Maria Silva on 2/3/23.
//

import SwiftUI

struct TextfieldIcon: View {
    var iconName: String
    var gradient1: [Color] = [Color.init(red: 101/255, green: 134/255, blue: 1), Color.init(red: 1, green: 64/255, blue: 80/255), Color.init(red: 109/255, green: 1, blue: 185/255), Color.init(red: 39/255, green: 232/255, blue: 1)
    ]
    @Binding var editing: Bool
    @Binding var passedImage: UIImage?
    
    var body: some View {
        ZStack {
           
                ZStack {
                    if editing {
                        AngularGradient(gradient: Gradient(colors: gradient1), center: .center, angle: .degrees(0)
                        )
                        .blur(radius: 10.0)
                    }
                    Color("pink")
                        .cornerRadius(12)
                        .opacity(0.8)
                    .blur(radius: 3.0)
                }
    
        }
        .cornerRadius(12)
        .overlay(
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("gold2"), lineWidth: 1)
                    .blendMode(.overlay)
                if passedImage != nil {
//                    for an image - will work on in future 
//                    UIImage(named: "\(passedImage)")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 28, height: 28, alignment: .center)
//                        .cornerRadius(8)
                } else {
                    Image(systemName: iconName)
                        .gradientForeground(colors: [Color("gold2"), Color("gold2")])
                        .font(.system(size: 17, weight: .medium))
                }
            }
        )
        .frame(width: 36, height: 36, alignment: .center)
        .padding([.vertical, .leading], 8)
    }
}

struct TextfieldIcon_Previews: PreviewProvider {
    static var previews: some View {
        TextfieldIcon(iconName: "key.fill", editing: .constant(true), passedImage: .constant(nil))
    }
}
