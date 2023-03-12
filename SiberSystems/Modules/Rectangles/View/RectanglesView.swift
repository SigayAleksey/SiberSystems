//
//  RectanglesView.swift
//  SiberSystems
//
//  Created by Alexey Sigay on 09.03.2023.
//

import SwiftUI

struct RectanglesView<ViewModel: RectanglesViewModelProtocol>: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel: ViewModel
    
    // MARK: - View body
    
    var body: some View {
        NavigationView {
            Form {
                Section { EmptyView() }
                ForEach(viewModel.rectangles) { rectangle in
                    Section {
                        RectangleView(rectangle: rectangle)
                    }
                }
                NavigationLink("Add rectangle") {
                    SaveRectangleFactory.create(context: nil)
                }
                Section {
                    NavigationLink("Display the rectangles map") {
                        RectanglesMapFactory.create()
                    }
                }
            }
            .onAppear(){
                viewModel.refteshData()
            }
            .navigationTitle("Rectangles")
        }
    }
}

struct RectanglesView_Previews: PreviewProvider {
    static var previews: some View {
        RectanglesView(
            viewModel: RectanglesViewModel.Stub.Full()
        )
    }
}
