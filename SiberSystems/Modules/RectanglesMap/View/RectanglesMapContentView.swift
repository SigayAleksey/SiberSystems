//
//  RectanglesMapContentView.swift
//  SiberSystems
//
//  Created by Alexey Sigay on 10.03.2023.
//

import SwiftUI

struct RectanglesMapContentView<ViewModel: RectanglesMapViewModelProtocol>: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel: ViewModel
    
    // MARK: - View body
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ForEach(viewModel.rectangles) { rectangle in
                    Rectangle()
                        .frame(width: rectangle.frame.width, height: rectangle.frame.height, alignment: .center)
                        .position(x: rectangle.frame.midX, y: rectangle.frame.midY)
                        .foregroundColor(Color(hue: rectangle.colorHUE, saturation: 1, brightness: 1))
                }
                .task {
                    viewModel.displaySizeWasChanged(geometry.size)
                }
            }
        }
        .onAppear() {
            viewModel.displaySizeWasChanged(CGSize())
        }
    }
}

struct RectanglesMapContentView_Previews: PreviewProvider {
    static var previews: some View {
        RectanglesMapContentView(
            viewModel: RectanglesMapViewModel.Stub.Full())
    }
}
