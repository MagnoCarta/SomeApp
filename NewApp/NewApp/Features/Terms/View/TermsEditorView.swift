//
//  TermsEditorView.swift
//  NewApp
//
//  Created by Gilberto Magno on 12/05/24.
//

import SwiftUI

struct TermsEditorView: View {
    @State var name: String
    @State var keywords: String
    @State var description: String
    @State var theme: Int

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                NATextField(title: "Name", text: $name)
                NATextField(title: "Keywords",
                            caption: "Separated by , (comma)",
                            text: $keywords)
                
                NATextEditor(title: "Description",
                             text: $description)

                NARadioButtonGroup(title: "Theme",
                                   currentSelection: $theme)
                Spacer()
            }
            .padding()
            .background(NABackground())
            .navigationTitle("New Box")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        print("Cancel")
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        print("Cancel")
                    }
                    .fontWeight(.bold)
                }
            }
        }
    }
}

struct BoxEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TermsEditorView(name: "",
                      keywords: "",
                      description: "",
                      theme: 0)
    }
}
