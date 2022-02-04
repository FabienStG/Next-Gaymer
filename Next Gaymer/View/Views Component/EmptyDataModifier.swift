//
//  EmptyDataModifier.swift
//  Next Gaymer
//
//  Created by Fabien Saint Germain on 03/02/2022.
//

import SwiftUI

struct EmptyDataModifier<Placeholder: View>: ViewModifier {

    let items: [Any]
    let placeholder: Placeholder

    @ViewBuilder
    func body(content: Content) -> some View {
        if !items.isEmpty {
            content
        } else {
            placeholder
        }
    }
}
