//
//  SaveRectangleViewModel.swift
//  SiberSystems
//
//  Created by Alexey Sigay on 09.03.2023.
//

import Foundation

@MainActor
protocol SaveRectangleViewModelProtocol: ObservableObject {
    var state: FeatureState { get }
    var existingRectangle: VMRectangle? { get }
    func saveRectangle(with coordinates: RectangleCoordinates)
}

@MainActor
final class SaveRectangleViewModel: SaveRectangleViewModelProtocol {
    
    // MARK: - Properties
    
    @Published private(set) var state: FeatureState = .none
    private(set) var existingRectangle: VMRectangle?
    
    // MARK: - Private properties
    
    private let dataStore: DataStoring
    
    // MARK: - Init
    
    init(
        dataStore: DataStoring,
        existingRectangle: VMRectangle?
    ) {
        self.dataStore = dataStore
        self.existingRectangle = existingRectangle
    }
    
    // MARK: - Functions
    
    func saveRectangle(with coordinates: RectangleCoordinates) {
        guard
            let originX = coordinates.originX,
            let originY = coordinates.originY,
            let offsetX = coordinates.offsetX,
            let offsetY = coordinates.offsetY
        else {
            state = .alert("Coordinate text fields were not filled")
            return
        }
        
        let rectangle = VMRectangle(
            id: existingRectangle?.id ?? UUID(),
            origin: CGPoint(x: originX, y: originY),
            offset: CGPoint(x: offsetX, y: offsetY)
        )
        
        do {
            try dataStore.saveRectangle(rectangle)
            
            if existingRectangle == nil {
                state = .alert("The rectangle has been added")
            } else {
                state = .alert("The rectangle has been edited")
            }
        } catch DataStoreError.intersection(let uuid)  {
            state = .alert("There is intersection with another rectangle. UUID: \(uuid)")
        } catch {
            state = .alert("Unknown error")
        }
    }
}

extension SaveRectangleViewModel {
    struct Stub {
        class Create: SaveRectangleViewModelProtocol {
            var state: FeatureState = .none
            var existingRectangle: VMRectangle? = nil
            func saveRectangle(with: RectangleCoordinates) { }
        }
        class Edit: SaveRectangleViewModelProtocol {
            var state: FeatureState = .none
            var existingRectangle: VMRectangle? = VMRectangle.Stub.rectangle1
            func saveRectangle(with: RectangleCoordinates) { }
        }
    }
}
