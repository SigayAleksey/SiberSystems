//
//  RectanglesMapFactory.swift
//  SiberSystems
//
//  Created by Alexey Sigay on 10.03.2023.
//

import SwiftUI

struct RectanglesMapFactory {
    @MainActor
    static func create() -> some View {
        let viewModel = RectanglesMapViewModel(
            dataStore: DataStore.shared,
            coordinatesMapper: CoordinatesMapper()
        )
        return  RectanglesMapView(viewModel: viewModel)
    }
}
