//
//  SaveRectangleView.swift
//  SiberSystems
//
//  Created by Alexey Sigay on 09.03.2023.
//

import SwiftUI

struct SaveRectangleView<ViewModel: SaveRectangleViewModelProtocol>: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Private properties
    
    @State private var originX: Int?
    @State private var originY: Int?
    @State private var offsetX: Int?
    @State private var offsetY: Int?
    
    // MARK: - View body
    
    var body: some View {
        switch viewModel.state {
        case .none:
            Form {
                Section { EmptyView() }
                VStack(spacing: 12) {
                    Group {
                        TextField("Origin X", value: $originX, format: .number)
                        TextField("Origin Y", value: $originY, format: .number)
                        TextField("Offset X", value: $offsetX, format: .number)
                        TextField("Offset Y", value: $offsetY, format: .number)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(UIKeyboardType.numberPad)
                    
                    Button(viewModel.existingRectangle == nil ? "Create" : "Save") {
                        viewModel.saveRectangle(
                            with: RectangleCoordinates(
                                originX: originX,
                                originY: originY,
                                offsetX: offsetX,
                                offsetY: offsetY
                            )
                        )
                    }
                }
                .navigationTitle(
                    viewModel.existingRectangle == nil ? "Create Rectangle" : "Edit Rectangle"
                )
            }.onAppear {
                if let existingRectangle = viewModel.existingRectangle {
                    originX = Int(existingRectangle.origin.x)
                    originY = Int(existingRectangle.origin.y)
                    offsetX = Int(existingRectangle.offset.x)
                    offsetY = Int(existingRectangle.offset.y)
                }
            }
        case .alert(let message):
            Text(message)
                .navigationTitle(
                    viewModel.existingRectangle == nil ? "Create Rectangle" : "Edit Rectangle"
                )
        }
            
    }
}

struct SaveRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        SaveRectangleView(viewModel: SaveRectangleViewModel.Stub.Create())
            .previewDisplayName("Create")
        
        SaveRectangleView(viewModel: SaveRectangleViewModel.Stub.Edit())
            .previewDisplayName("Edit")
    }
}
