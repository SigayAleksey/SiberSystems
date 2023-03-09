//
//  RectanglesFactory.swift
//  SiberSystems
//
//  Created by Alexey Sigay on 09.03.2023.
//

import SwiftUI

struct RectanglesFactory {
    @MainActor
    static func create() -> some View {
        let viewModel = RectanglesViewModel(
            dataStore: DataStore.shared
        )
        return RectanglesView(viewModel: viewModel)
    }
}
