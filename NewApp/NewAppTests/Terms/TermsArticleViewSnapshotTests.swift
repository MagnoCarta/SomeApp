//
//  ArticleViewSnapshotTests.swift
//  NewAppTests
//
//  Created by Gilberto Magno on 13/05/24.
//

import XCTest
import SnapshotTesting
@testable import NewApp
import SwiftUI

final class TermsArticleViewSnapshotTests: XCTestCase {
    
    func testMyTermsArticleView() {
        let view = TermsArticleView(viewModel: .init(boxes: [(Everything.Request(searchIn: "Teste Mock"),.aquamarine)]))
        
        assertSnapshot(
            matching: view, as: .image(
                layout: .device(config: .iPhone13Pro),
                traits: UITraitCollection(userInterfaceStyle: .light)
            ))

        assertSnapshot(
            matching: view, as: .image(
                layout: .device(config: .iPhone13Pro),
                traits: UITraitCollection(userInterfaceStyle: .dark)
            ))
    }
}
