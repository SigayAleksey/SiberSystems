//
//  DataStore.swift
//  SiberSystems
//
//  Created by Alexey Sigay on 09.03.2023.
//

import Foundation

@MainActor
protocol DataStoring {
    var rectangles: [VMRectangle] { get }
    
    func addRectangle(_ rectangle: VMRectangle)
    func updateRectangle(_ rectangle: VMRectangle)
    func removeRectangle(_ rectangleID: UUID)
}

@MainActor
final class DataStore: DataStoring {
    
    // MARK: - Properties
    
    static let shared = DataStore()
    
    private(set) var rectangles: [VMRectangle] = []
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - Functions

    func addRectangle(_ rectangle: VMRectangle) {
        guard isRectangleValid(rectangle) else { return }
        rectangles.append(rectangle)
    }

    func updateRectangle(_ rectangle: VMRectangle) {
        guard
            let index = rectangles.firstIndex(where: { $0.id == rectangle.id } ),
            isRectangleValid(rectangle) else { return }
        rectangles[index].origin = rectangle.origin
        rectangles[index].offset = rectangle.offset
    }

    func removeRectangle(_ rectangleID: UUID) {
        rectangles.removeAll(where: { $0.id == rectangleID } )
    }

    // MARK: - Private functions

    private func isRectangleValid(_ rectangle: VMRectangle) -> Bool {
        var isValid = true
        rectangles.forEach { addedRectangle in
            if addedRectangle.id != rectangle.id,
               addedRectangle.frame.intersects(rectangle.frame) {
                isValid = false
                return
            }
        }

        return isValid
    }
}

extension DataStore {
    struct Stub {
        class Empty: DataStoring {
            var rectangles: [VMRectangle] = []
            
            func addRectangle(_ rectangle: VMRectangle) { }
            func updateRectangle(_ rectangle: VMRectangle) { }
            func removeRectangle(_ rectangleID: UUID) { }
        }
        class Full: DataStoring {
            var rectangles: [VMRectangle] = [VMRectangle.Stub.rectangle1, VMRectangle.Stub.rectangle2]
            
            func addRectangle(_ rectangle: VMRectangle) { }
            func updateRectangle(_ rectangle: VMRectangle) { }
            func removeRectangle(_ rectangleID: UUID) { }
        }
    }
}
