//
//  RectanglesViewModel.swift
//  SiberSystems
//
//  Created by Alexey Sigay on 09.03.2023.
//

import Foundation

@MainActor
protocol RectanglesViewModelProtocol: ObservableObject {
    var rectangles: [VMRectangle] { get }
    func getRectangles()
}

@MainActor
final class RectanglesViewModel: RectanglesViewModelProtocol {
    
    // MARK: - Properties
    
    @Published private(set) var rectangles: [VMRectangle] = []
    
    // MARK: - Private properties
    
    private var dataStore: DataStoring
    
    // MARK: - Init
    
    init(dataStore: DataStoring) {
        self.dataStore = dataStore
    }
    
    // MARK: - Functions
    
    func getRectangles() {
        rectangles = dataStore.rectangles
    }
    
    func editRectangle(_ rectangleID: UUID) {
        
    }
}

extension RectanglesViewModel {
    struct Stub {
        class Empty: RectanglesViewModelProtocol {
            var rectangles: [VMRectangle] = []
            func getRectangles() { }
        }
        class Full: RectanglesViewModelProtocol {
            var rectangles: [VMRectangle] = [VMRectangle.Stub.rectangle1, VMRectangle.Stub.rectangle2]
            func getRectangles() { }
        }
    }
}
