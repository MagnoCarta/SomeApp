//
//  ArticleCard.swift
//  NewApp
//
//  Created by Gilberto Magno on 11/05/24.
//

import SwiftUI

struct ArticleCard: View {
    
    var article: Article
    
    var body: some View {
        VStack(spacing: 0) {
            upperBody
            bottomBody
                .offset(y: -4)
        }
        .background(.primaryBackground)
        .clipShape(.rect(cornerSize: CGSize(width: 16, height: 16)))
        .padding(.horizontal)
    }
    
    var upperBody: some View {
        ZStack {
            image
            NABackground()
                .clipShape(
                    .rect(
                        topLeadingRadius: 16,
                        topTrailingRadius: 16
                    )
                )
                .opacity(0.6)
                .overlay {
                    VStack (alignment: .leading){
                        Text(article.author ?? "Unknowm Author")
                            .font(.largeTitle)
                    }
                    .foregroundStyle(.naBlack)
                }
        }
    }
    
    var bottomBody: some View {
        Rectangle()
            .fill(Color.white)
            .clipShape(
                .rect(
                    bottomLeadingRadius: 16,
                    bottomTrailingRadius: 16
                )
            )
            .overlay {
                Text(article.title ?? "Unknown Title")
                    .foregroundStyle(.black)
                    .padding()
            }
    }
    
    @ViewBuilder var image: some View {
        if Cache.isArticleInCache(for: article) {
            Cache.getImage(for: article)
                .resizable()
                .clipShape(.rect(cornerSize: CGSize(width: 16, height: 16)))
        } else {
            if let imageURL = article.urlToImage,
               let url = URL(string: imageURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .clipShape(.rect(cornerSize: CGSize(width: 16, height: 16)))
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
}
