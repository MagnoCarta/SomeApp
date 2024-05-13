//
//  TermsCardView.swift
//  NewApp
//
//  Created by Gilberto Magno on 12/05/24.
//

import SwiftUI

struct TermsCardView: View {
    @State private var boxName: String
    @State private var numberOfTerms: Int
    @State private var theme: NATheme

    init(boxName: String, numberOfTerms: Int, theme: NATheme) {
        self.boxName = boxName
        self.numberOfTerms = numberOfTerms
        self.theme = theme
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(boxName)
                .font(.title3)
                .fontWeight(.bold)
            
            Label("\(numberOfTerms) terms", systemImage: "doc.plaintext.fill")
                .padding(8)
                .background(Color.naBlack.opacity(0.2))
                .cornerRadius(10)
        }
        .foregroundStyle(Color.naBlack)
        .padding(16)
        .frame(width: 165, alignment: .leading)
        .background(theme.color)
        .cornerRadius(10)
    }
    
    
}

struct TermsCardView_Previews: PreviewProvider {
    static var previews: some View {
        TermsCardView(boxName: "Math",
                    numberOfTerms: 35,
                    theme: .mauve)
    }
}
