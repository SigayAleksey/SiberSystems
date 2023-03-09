//
//  SaveRectangleFactory.swift
//  SiberSystems
//
//  Created by Alexey Sigay on 09.03.2023.
//

import SwiftUI

struct SaveRectangleFactory {
    @MainActor
    static func create(context: VMRectangle?) -> some View {
        let viewModel = SaveRectangleViewModel(
            dataStore: DataStore.shared,
            existingRectangle: context
        )
        return SaveRectangleView(viewModel: viewModel)
    }
}
