//
//  ArticleView.swift
//  NewApp
//
//  Created by Gilberto Magno on 11/05/24.
//

import SwiftUI

struct ArticleView: View {
    
    @State var viewModel: ArticleViewModel
    @State private var direction: Direction = .none
       
       var body: some View {
           ArticleLayout(cor: cor,
                       titulo: title,
                       card: card) {
               segment
           }
       }
       
       var title: Text {
           Text((viewModel.article.author ?? "Unknown Author").uppercased())
               .foregroundStyle(.white)
               .font(.largeTitle)
               .bold()
       }
       
       var card: ArticleDragCard {
           ArticleDragCard(image: viewModel.articleImage,
                           articles: viewModel.articles,
                           article: $viewModel.article,
                           direction: $direction,
                           actualIndex: $viewModel.actualIndex)
       }
       
       var cor: Color {
           .lavender
       }
       
       var segment: some View {
           NASegment(points: viewModel.articles.count,
                     selectedPoint: viewModel.actualIndex%4,
                     color: .white)
               .animation(.easeInOut, value: viewModel.actualIndex)
       }
       
}
