//
//  TermsArticleView.swift
//  NewApp
//
//  Created by Gilberto Magno on 12/05/24.
//

import Foundation
import SwiftUI

struct TermsArticleView: View {
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 140), spacing: 20),
        GridItem(.adaptive(minimum: 140), spacing: 20)
    ]
    
    @State var viewModel: TermsViewModel
    @State var router: NARouter = .shared
    @State private var isCreatingNewBox: Bool = false
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.boxes, id: \.0.id) { box,theme in
                        TermsCardView(boxName: box.searchIn,
                                      numberOfTerms: 0,
                                      theme: theme)
                        .onTapGesture {
                            router.pushToTerm(box)
                        }
                        
                    }
                }
                .padding(40)
            }
            .navigationDestination(for: Everything.Request.self) { term in
                ArticleListView(viewModel: ArticleListViewModel(request: term))
            }
            .padding(-20)
            .navigationTitle("Boxes")
            .background(NABackground())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isCreatingNewBox.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isCreatingNewBox) {
                TermsEditorView(name: "",
                                keywords: "",
                                description: "",
                                theme: 0)
            }
        }
    }
}

struct TermsView_Previews: PreviewProvider {
    
    static let viewModel: TermsViewModel = {
        return TermsViewModel()
    }()
    
    static var previews: some View {
        NavigationStack {
            TermsArticleView(viewModel: TermsView_Previews.viewModel)
        }
    }
}

