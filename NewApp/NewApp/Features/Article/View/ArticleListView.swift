//
//  ArticleListView.swift
//  NewApp
//
//  Created by Gilberto Magno on 11/05/24.
//

import SwiftUI

struct ArticleListView: View {
    
    @State var viewModel: ArticleListViewModelProtocol = ArticleListViewModel()
    @State var router: NARouter = .shared
    var columns: [GridItem] = [
        .init(.flexible())
    ]
    
    var body: some View {
        
            ZStack {
                NABackground()
                VStack {
                    Divider()
                    listBody
                }
            }
            .navigationDestination(for: Article.self) { article in
                ArticleView(viewModel: .init(article: article,
                                             articles: viewModel.filteredArticles))
            }
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchText)
    }
    
    var listBody: some View {
        ScrollView {
            LazyVGrid(columns: columns,spacing: 32) {
                ForEach(viewModel.filteredArticles) { article in
                    ArticleCard(article: article)
                        .frame(height: 173)
                        .frame(maxWidth: .infinity)
                        .onAppear {
                            self.viewModel.setNextPageNeeds(article: article)
                        }
                        .onTapGesture {
                            router.pushToArticle(article)
                        }
                }
                
            }
        }
    }
    
    
}


#Preview {
    ArticleListView()
}

class ArticleListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

