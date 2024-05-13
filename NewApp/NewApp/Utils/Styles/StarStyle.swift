//
//  StarStyle.swift
//  NewApp
//
//  Created by Gilberto Magno on 13/05/24.
//

import SwiftUI

struct StarStyle: ButtonStyle {
    
    @Binding var isFilled: Bool?
    var color: Color
    var size: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: isFilled ?? false  ? "star.fill" : "star")
            .resizable()
            .fontWeight(.thin)
            .foregroundStyle(color)
            .frame(width: size,height: size)
    }
    
    
}
