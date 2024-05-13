//
//  ArticleLayout.swift
//  NewApp
//
//  Created by Gilberto Magno on 13/05/24.
//

import SwiftUI

struct ArticleLayout<Segment: View>: View {
    var cor: Color
    var titulo: Text
    var card: ArticleDragCard
    var segmento: () -> Segment
    
    var body: some View {
        ZStack {
            cor.ignoresSafeArea()
            VStack(spacing: 40) {
                titulo
                VStack(spacing: 60) {
                    card
                    segmento()
                }
                .padding(.bottom, 40)
            }
            .padding(.top, 90)
        }
    }
    
}
