//
//  Star.swift
//  NewApp
//
//  Created by Gilberto Magno on 13/05/24.
//

import SwiftUI

struct Star: ViewModifier {
    
    @Binding var isFilled: Bool?
    var color: Color
    var size: CGFloat = 45
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .trailing) {
                VStack {
                    Spacer()
                    Button("") {
                        withAnimation {
                            isFilled?.toggle()
                        }
                    }.buttonStyle(StarStyle(isFilled: $isFilled, color: color, size: size))
                }
                .padding(12)
            }
    }
}

extension View {
    func star(isFilled: Binding<Bool?>, color: Color) -> some View {
        modifier(Star(isFilled: isFilled, color: color))
    }
}
