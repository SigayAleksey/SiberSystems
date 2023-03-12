//
//  RectangleImage.swift
//  SiberSystems
//
//  Created by Alexey Sigay on 10.03.2023.
//

import Foundation

struct RectangleImage: Identifiable {
    let id: UUID
    var frame: CGRect
    
    let colorHUE = Double.random(in: 0.1...0.99)
}

extension RectangleImage {
    struct Stub {
        static let rectangle1 = RectangleImage (
            id: UUID(),
            frame: CGRect(x: 50, y: 50, width: 50, height: 50)
        )
        static let rectangle2 = RectangleImage (
            id: UUID(),
            frame: CGRect(x: 50, y: 200, width: 100, height: 50)
        )
    }
}
