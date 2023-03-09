//
//  VMRectangle.swift
//  SiberSystems
//
//  Created by Alexey Sigay on 09.03.2023.
//

import Foundation

struct VMRectangle: Identifiable {
    let id: UUID
    var origin: CGPoint
    var offset: CGPoint
    
    let colorHUE = Double.random(in: 0.1...0.99)
    var frame: CGRect {
        CGRect(
            origin: origin,
            size: CGSize(width: offset.x - origin.x, height: offset.y - origin.y)
        )
    }
    
    init(id: UUID, origin: CGPoint, offset: CGPoint) {
        self.id = id
        self.origin = CGPoint(x: min(origin.x, offset.x), y: min(origin.y, offset.y))
        self.offset = CGPoint(x: max(origin.x, offset.x), y: max(origin.y, offset.y))
    }
}

extension VMRectangle {
    struct Stub {
        static let rectangle1 = VMRectangle(id: UUID(), origin: CGPoint(x: 50, y: 50), offset: CGPoint(x: 100, y: 100))
        static let rectangle2 = VMRectangle(id: UUID(), origin: CGPoint(x: 150, y: 50), offset: CGPoint(x: 200, y: 200))
    }
}
