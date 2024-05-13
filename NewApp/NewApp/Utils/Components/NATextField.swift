//
//  NATextField.swift
//  NewApp
//
//  Created by Gilberto Magno on 12/05/24.
//

import SwiftUI

struct NATextField: View {
    @State var title: String = ""
    @State var caption: String = ""

    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            if !title.isEmpty {
                Text(title)
                    .font(.body)
                    .fontWeight(.bold)
            }

            TextField("", text: $text)
                .textFieldStyle(NATextFieldStyle())

            if !caption.isEmpty {
                Text(caption)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.leading, 8)
            }
        }
        .foregroundStyle(Color.naBlack)
    }
}

struct NATextField_Previews: PreviewProvider {
    static var previews: some View {
        NATextField(title: "Title",
                    caption: "caption",
                    text: .constant("Text"))
            .padding()
    }
}

struct NATextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(height: 42)
            .padding(.horizontal, 8)
            .background(Color.primaryBackground)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.25) ,radius: 10)
    }
}
