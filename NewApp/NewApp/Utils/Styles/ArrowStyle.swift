//
//  ArrowStyle.swift
//  NewApp
//
//  Created by Gilberto Magno on 13/05/24.
//

import SwiftUI

struct ArrowStyle: ButtonStyle {
    
    var direction: Direction
    
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: "arrow.\(direction.rawValue)")
            .font(.headline)
    }
    
}
