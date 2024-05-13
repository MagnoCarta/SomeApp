//
//  TermsViewModel.swift
//  NewApp
//
//  Created by Gilberto Magno on 12/05/24.
//

import SwiftUI

@Observable
class TermsViewModel {
    var termManager = TermManager()
    var terms: [Everything.Request : NATheme]
    
    init(terms: [Everything.Request: NATheme] = [:]) {
        self.terms = terms
    }
    
    func updateTerms() {
        self.terms = termManager.getTerms()
    }
    
}

enum NATheme: Int {
    case lavender
    case mauve
    case aquamarine
    
    var color: Color {
        switch self {
        case .lavender:
            Color.lavender
        case .mauve:
            Color.mauve
        case .aquamarine:
            Color.aquamarine
        }
    }
}
