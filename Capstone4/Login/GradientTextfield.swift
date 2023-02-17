//
//  GradientTextField.swift
//  Capstone4
//
//  Created by Maria Silva on 2/7/23.
//

import SwiftUI

struct GradientTextfield: View {
    @Binding var editingTextfield: Bool
    @Binding var textfieldString: String
    var textfieldPlaceholder: String
    var textfieldIconString: String
//    private let generator = UISelectionFeedbackGenerator()
    
    var body: some View {
        HStack(spacing: 12.0) {
            TextfieldIcon(iconName: textfieldIconString, editing: $editingTextfield, passedImage: .constant(nil))
            TextField(textfieldPlaceholder, text: $textfieldString) { isEditing in
                editingTextfield = isEditing
            }
                .colorScheme(.dark)
                .foregroundColor(Color.black.opacity(0.7))
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white, lineWidth: 1.0)
                .blendMode(.overlay)
        )
        .background(
            Color("tan")
                .cornerRadius(16.0)
                .opacity(0.2)
        )
    }
}

struct GradientTextfield_Previews: PreviewProvider {
    static var previews: some View {
        GradientTextfield(editingTextfield: .constant(true), textfieldString: .constant("some string here"), textfieldPlaceholder: "test textfield", textfieldIconString: "textformat.alt")
    }
}
