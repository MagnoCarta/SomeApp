//
//  NARadioButton.swift
//  NewApp
//
//  Created by Gilberto Magno on 12/05/24.
//

import SwiftUI

struct NARadioButtonGroup: View {
    @State var title: String = ""
    @Binding var currentSelection: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if !title.isEmpty {
                Text(title)
                    .font(.body)
                    .fontWeight(.bold)
            }

            HStack(spacing: 20) {
                NARadioButton(tag: 0,
                              currentSelection: $currentSelection,
                              color: Color.mauve)
                NARadioButton(tag: 1,
                              currentSelection: $currentSelection,
                              color: Color.lavender)
                NARadioButton(tag: 2,
                              currentSelection: $currentSelection,
                              color: Color.aquamarine)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct NARadioButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        NARadioButtonGroup(title: "Theme", currentSelection: .constant(0))
    }
}


struct NARadioButton: View {
    let tag: Int
    @Binding var currentSelection: Int

    let color: Color

    var body: some View {
        ZStack {
            Circle()
                .fill(self.color)

            if currentSelection == tag {
                Circle()
                    .fill(Color.selection)
                    .frame(maxWidth: 30)
            }
        }
        .frame(maxWidth: 50)
        .onTapGesture {
            if currentSelection != tag {
                currentSelection = tag
            }
        }
    }
}

struct NARadioButton_Previews: PreviewProvider {
    static var previews: some View {
        NARadioButton(tag: 0,
                      currentSelection: .constant(0),
                      color: Color.mauve)
    }
}
