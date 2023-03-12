//
//  RectanglesMapView.swift
//  SiberSystems
//
//  Created by Alexey Sigay on 10.03.2023.
//

import SwiftUI

struct RectanglesMapView<ViewModel: RectanglesMapViewModelProtocol>: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    // MARK: - View body
    
    var body: some View {
        RectanglesMapContentView(viewModel: viewModel)
    }
}

struct RectanglesMapView_Previews: PreviewProvider {
    static var previews: some View {
        RectanglesMapView(viewModel: RectanglesMapViewModel.Stub.Full())
    }
}
