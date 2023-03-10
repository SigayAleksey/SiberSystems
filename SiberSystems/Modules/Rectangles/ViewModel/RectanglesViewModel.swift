//
//  RectanglesViewModel.swift
//  SiberSystems
//
//  Created by Alexey Sigay on 09.03.2023.
//

import Foundation
import Combine

@MainActor
protocol RectanglesViewModelProtocol: ObservableObject {
    var rectangles: [VMRectangle] { get }
    func refteshData()
}

@MainActor
final class RectanglesViewModel: RectanglesViewModelProtocol {
    
    // MARK: - Properties
    
    @Published private(set) var rectangles: [VMRectangle] = []
    
    // MARK: - Private properties
    
    private let dataStore: DataStoring
    
    private var rectanglesSubscription: AnyCancellable?
    
    // MARK: - Init
    
    init(dataStore: DataStoring) {
        self.dataStore = dataStore
        
        setupSubscriptions()
    }
    
    // MARK: - Private functions
    
    private func setupSubscriptions() {
        rectanglesSubscription = dataStore.rectangles.publisher
            .collect()
            .sink(receiveValue: { rectangles in
                self.rectangles = rectangles
            })
    }
    
    func refteshData() {
        rectangles = dataStore.rectangles
    }
}

extension RectanglesViewModel {
    struct Stub {
        class Empty: RectanglesViewModelProtocol {
            var rectangles: [VMRectangle] = []
            func refteshData() { }
        }
        class Full: RectanglesViewModelProtocol {
            var rectangles: [VMRectangle] = [VMRectangle.Stub.rectangle1, VMRectangle.Stub.rectangle2]
            func refteshData() { }
        }
    }
}
