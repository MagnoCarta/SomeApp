//
//  NABackground.swift
//  NewApp
//
//  Created by Gilberto Magno on 12/05/24.
//

import SwiftUI

struct NABackground: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.aquamarine,
                    Color.lavender,
                    Color.mauve
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing)

            Rectangle()
                .fill(Color.clear)
                .background(colorScheme == .light ? .regularMaterial : .thickMaterial)
        }
        .ignoresSafeArea()
    }
}

struct reBackground_Previews: PreviewProvider {
    static var previews: some View {
        NABackground()
    }
}
