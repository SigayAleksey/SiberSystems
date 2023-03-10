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
    
    func saveRectangle(_ rectangle: VMRectangle) throws
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
    
    func saveRectangle(_ rectangle: VMRectangle) throws {
        try checkRectangle(rectangle) {
            if let index = rectangles.firstIndex(where: { $0.id == rectangle.id } ) {
                rectangles[index].origin = rectangle.origin
                rectangles[index].offset = rectangle.offset
            } else {
                rectangles.append(rectangle)
            }
        } error: { uuid in
            throw DataStoreError.intersection(rectangleID: uuid)
        }
    }

    func removeRectangle(_ rectangleID: UUID) {
        rectangles.removeAll(where: { $0.id == rectangleID } )
    }

    // MARK: - Private functions
    
    private func checkRectangle(_ rectangle: VMRectangle, success: ()->(), error: (UUID) throws -> ()) throws {
        try rectangles.forEach { addedRectangle in
            if addedRectangle.id != rectangle.id,
               addedRectangle.frame.intersects(rectangle.frame) {
                
                try error(addedRectangle.id)
            }
        }
        success()
    }
}

extension DataStore {
    struct Stub {
        class Empty: DataStoring {
            var rectangles: [VMRectangle] = []
            
            func saveRectangle(_ rectangle: VMRectangle) { }
            func removeRectangle(_ rectangleID: UUID) { }
        }
        class Full: DataStoring {
            var rectangles: [VMRectangle] = [VMRectangle.Stub.rectangle1, VMRectangle.Stub.rectangle2]
            
            func saveRectangle(_ rectangle: VMRectangle) { }
            func removeRectangle(_ rectangleID: UUID) { }
        }
    }
}
