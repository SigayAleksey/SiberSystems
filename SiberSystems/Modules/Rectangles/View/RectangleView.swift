//
//  RectangleView.swift
//  SiberSystems
//
//  Created by Alexey Sigay on 09.03.2023.
//

import SwiftUI

struct RectangleView: View {
    
    // MARK: - Private properties
    
    let rectangle: VMRectangle
    
    // MARK: - View body
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack {
                    Text("X: \(Int(rectangle.origin.x))")
                    Text("Y: \(Int(rectangle.origin.y))")
                }
                Spacer()
            }
            HStack {
                Spacer()
                VStack {
                    Text("X: \(Int(rectangle.offset.x))")
                    Text("Y: \(Int(rectangle.offset.y))")
                }
            }
            NavigationLink("Edit") {
                SaveRectangleFactory.create(context: rectangle)
            }
        }
    }
}

struct RectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleView(rectangle: VMRectangle.Stub.rectangle1)
    }
}
