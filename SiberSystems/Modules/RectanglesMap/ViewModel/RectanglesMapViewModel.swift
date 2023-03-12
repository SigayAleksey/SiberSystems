//
//  RectanglesMapViewModel.swift
//  SiberSystems
//
//  Created by Alexey Sigay on 10.03.2023.
//

import Foundation

@MainActor
protocol RectanglesMapViewModelProtocol: ObservableObject {
    var rectangles: [RectangleImage] { get }
    func displaySizeWasChanged(_ size: CGSize)
}

@MainActor
final class RectanglesMapViewModel: RectanglesMapViewModelProtocol {
    
    // MARK: - Properties
    
    @Published private(set) var rectangles: [RectangleImage] = []

    // MARK: - Private properties
    
    private let dataStore: DataStoring
    private let coordinatesMapper: CoordinatesMapping
    
    // MARK: - Init
    
    init(
        dataStore: DataStoring,
        coordinatesMapper: CoordinatesMapping
    ) {
        self.dataStore = dataStore
        self.coordinatesMapper = coordinatesMapper
    }
    
    // MARK: - Functions
    
    func displaySizeWasChanged(_ size: CGSize) {
        calculateRectangles(in: size)
    }
    
    // MARK: - Private functions
    
    func calculateRectangles(in viewSize: CGSize) {
        rectangles = coordinatesMapper.mapRectangles(dataStore.rectangles, in: viewSize)
    }
}

extension RectanglesMapViewModel {
    struct Stub {
        class Empty: RectanglesMapViewModelProtocol {
            var rectangles: [RectangleImage] = []
            func displaySizeWasChanged(_ size: CGSize) { }
        }
        class Full: RectanglesMapViewModelProtocol {
            var rectangles: [RectangleImage] = [RectangleImage.Stub.rectangle1, RectangleImage.Stub.rectangle1]
            func displaySizeWasChanged(_ size: CGSize) { }
        }
    }
}

