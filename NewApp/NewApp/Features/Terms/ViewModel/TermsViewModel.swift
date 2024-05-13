//
//  TermsViewModel.swift
//  NewApp
//
//  Created by Gilberto Magno on 12/05/24.
//

import SwiftUI

@Observable
class TermsViewModel {
    var boxes: [(Everything.Request,NATheme)]
    
    init(boxes: [(Everything.Request,NATheme)] = []) {
        self.boxes = boxes
    }
}

enum NATheme {
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
