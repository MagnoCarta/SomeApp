//
//  NASegment.swift
//  NewApp
//
//  Created by Gilberto Magno on 13/05/24.
//

import SwiftUI

struct NASegment: View {
    
    var points: Int
    var selectedPoint: Int
    var color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<4) { point in
                Circle()
                    .frame(width: 10,height: 10)
                    .foregroundStyle(point == selectedPoint ? color : .gray)
            }
        }
    }
}
