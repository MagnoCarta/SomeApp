//
//  ArticleDragCard.swift
//  NewApp
//
//  Created by Gilberto Magno on 13/05/24.
//

import SwiftUI

struct ArticleDragCard: View {
    
    var image: Image
    var articles: [Article]
    
    @Binding var article: Article
    @Binding var direction: Direction
    @Binding var actualIndex: Int
    
    @State private var dragAmout: CGSize = .zero
    @State private var cardAngle: Angle = .zero
    
    private let duration: CGFloat = 0.18
    @State private var isScrolling: Bool = false

    
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 25.0, height: 25.0))
            .fill(.shadow(.inner(radius: 3)))
            .foregroundStyle(.white)
            .overlay(alignment: .top) {
                content
            }
            .star(isFilled: $article.isFavorite, color: .lavender)
            .cornerRadius(25)
            .offset(dragAmout)
            .rotationEffect(cardAngle)
            .frame(width: 344,height: 508)
            .gesture(
                DragGesture()
                    .onChanged(dragDidChange)
                    .onEnded(dragDidEnd)
            )
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(spacing: 16) {
                image
                    .resizable()
                    .frame(height: 181)
                Text(article.author ?? "Unknown Author")
                    .font(.largeTitle)
                    .bold()
                ScrollView {
                    Text(article.summary ?? "No Content")
                }
                .gesture(
                    DragGesture()
                        .onChanged(didDragText)
                )
            }
            HStack(spacing: 16) {
                VStack {
                    Image(.no)
                        .resizable()
                        .frame(width: 103, height: 108)
                }
                Text(article.publishedAt ?? "No Published Date")
                    .font(.footnote)
            }
        }
        .padding()
    }
    
    private func dragDidChange(_ gesture: DragGesture.Value) {
        if !isScrolling {
            dragAmout = gesture.translation
            cardAngle = Angle(degrees: gesture.translation.width * 0.05)
            
            if gesture.translation.width > 0 && direction != .right {
                withAnimation(.linear(duration: duration)) {
                    direction = .right
                }
            }
            
            if gesture.translation.width < 0 && direction != .left {
                withAnimation(.linear(duration: duration)) {
                    direction = .left
                }
            }
            
            if gesture.translation == .zero && direction != .none {
                withAnimation(.linear(duration: duration)) {
                    direction = .none
                }
            }
        }
    }
    
    private func dragDidEnd(_ gesture: DragGesture.Value) {
        if !isScrolling {
            let articleNumber = articles.count
            if direction == .left && actualIndex > 0 {
                actualIndex -= 1
            } else if direction == .right && actualIndex < articleNumber - 1 {
                actualIndex += 1
            }
            withAnimation(.linear(duration: duration)) {
                self.article = articles[actualIndex]
                dragAmout = .zero
                cardAngle = .zero
                direction = .none
            }
        }
    }
    
    private func didDragText(_ gesture: DragGesture.Value) {
        self.isScrolling = true
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            self.isScrolling = false
        }
    }

    
    
}
