//
//  NATextEditor.swift
//  NewApp
//
//  Created by Gilberto Magno on 12/05/24.
//

import SwiftUI

struct NATextEditor: View {
    @State var title: String
    @Binding var text: String
    @State var maxSize: Int = 250

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.body)
                .fontWeight(.bold)

            VStack {
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .onChange(of: text) {
                        if text.count > maxSize {
                            self.text = String(text.prefix(maxSize))
                        }
                    }

                Divider()
                    .background(Color.naBlack.opacity(0.6))

                Text("\(maxSize)")
                    .font(.callout)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(8)
            .frame(height: 200)
            .background(Color.primaryBackground)
            .cornerRadius(10)
        }
    }
}

struct NATextEditor_Previews: PreviewProvider {
    static var previews: some View {
        NATextEditor(title: "Description", text: .constant("Text"), maxSize: 150)
            .padding()
    }
}
