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
    @State var theme: Int
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                NATextField(title: "Title", text: $name)
                NATextField(title: "Sources",
                            caption: "Separated by , (comma)",
                            text: $keywords)
                NARadioButtonGroup(title: "Theme",
                                   currentSelection: $theme)
                Spacer()
            }
            .padding()
            .background(NABackground())
            .navigationTitle("New Term")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        TermManager().addNewTerms(terms: [name : theme])
                        dismiss()
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
                      theme: 0)
    }
}
