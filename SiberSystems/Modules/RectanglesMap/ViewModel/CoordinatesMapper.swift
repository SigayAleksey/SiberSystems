//
//  CoordinatesMapper.swift
//  SiberSystems
//
//  Created by Alexey Sigay on 10.03.2023.
//

import UIKit

protocol CoordinatesMapping {
    func mapRectangles(_ rectangles: [VMRectangle], in viewSize: CGSize) -> [RectangleImage]
}

struct CoordinatesMapper: CoordinatesMapping {
    
    // MARK: - Functions
    
    func mapRectangles(_ rectangles: [VMRectangle], in viewSize: CGSize) -> [RectangleImage] {
        guard
            let firstRectangle = rectangles.first,
            firstRectangle.origin.x != firstRectangle.offset.x,
            firstRectangle.origin.y != firstRectangle.offset.y
        else {
            return []
        }
        
        var allRectanglesPerimeterBorder = PerimeterBorder(
            top: firstRectangle.origin.y,
            left: firstRectangle.origin.x,
            right: firstRectangle.offset.x,
            bottom: firstRectangle.offset.y
        )
        
        allRectanglesPerimeterBorder = defineAllRectanglesPerimeterBorder(for: rectangles, borderOfTheFirst: allRectanglesPerimeterBorder)
        
        let horizontalRectanglesOffset = -allRectanglesPerimeterBorder.left
        let verticalRectanglesOffset = -allRectanglesPerimeterBorder.top
        
        // All rectangles's area borders moved to a coordinate system with x=0 and y=0 as a start and min values of coordinates
        let displacementPerimeterBorder = normalizedPerimeterСoordinates(
            allRectanglesPerimeterBorder,
            horizontalOffset: horizontalRectanglesOffset,
            verticalOffset: verticalRectanglesOffset
        )
        let coordinateSystemsCoefficient = getCoordinateSystemsCoefficient(
            viewSize: viewSize,
            rectanglesPerimeterBorder: displacementPerimeterBorder
        )
        
        var mappedRectangles: [RectangleImage] = []
        rectangles.forEach { rectangle in
            let mappedRectangle = mapRectangle(
                rectangle,
                coefficient: coordinateSystemsCoefficient,
                horizontalOffset: horizontalRectanglesOffset,
                verticalOffset: verticalRectanglesOffset
            )
            mappedRectangles.append(mappedRectangle)
        }
        
        return mappedRectangles
    }
    
    // MARK: - Private functions
    
    private func getWindow() -> UIWindow? {
        UIApplication.shared.connectedScenes
            .filter( { $0.activationState == .foregroundActive } )
            .map( { $0 as? UIWindowScene } )
            .compactMap( { $0 } )
            .first?.windows
            .filter( { $0.isKeyWindow } ).first
    }
    
    private func getSafeAreaFrame(in window: UIWindow) -> CGRect {
        let insets = window.safeAreaInsets
        let bounds = window.screen.bounds
        
        return CGRect(
            x: insets.left,
            y: insets.top,
            width: bounds.width - insets.left - insets.right,
            height: bounds.height - insets.top - insets.bottom
        )
    }

    private func defineAllRectanglesPerimeterBorder(
        for rectangles: [VMRectangle],
        borderOfTheFirst: PerimeterBorder
    ) -> PerimeterBorder {
        var topBorder = borderOfTheFirst.top
        var leftBorder = borderOfTheFirst.left
        var rightBorder = borderOfTheFirst.right
        var bottomBorder = borderOfTheFirst.bottom
        
        rectangles.forEach { rectangle in
            if rectangle.origin.x < leftBorder {
                leftBorder = rectangle.origin.x
            }
            if rectangle.origin.y < topBorder {
                topBorder = rectangle.origin.y
            }
            if rectangle.offset.x > rightBorder {
                rightBorder = rectangle.offset.x
            }
            if rectangle.offset.y > bottomBorder {
                bottomBorder = rectangle.offset.y
            }
        }
        
        return PerimeterBorder(top: topBorder, left: leftBorder, right: rightBorder, bottom: bottomBorder)
    }
    
    private func normalizedPerimeterСoordinates(
        _ borders: PerimeterBorder,
        horizontalOffset: CGFloat,
        verticalOffset: CGFloat
    ) -> PerimeterBorder {
        PerimeterBorder(
            top: borders.top + verticalOffset,
            left: borders.left + horizontalOffset,
            right: borders.right + horizontalOffset,
            bottom: borders.bottom + verticalOffset
        )
    }
    
    private func getCoordinateSystemsCoefficient(viewSize: CGSize, rectanglesPerimeterBorder: PerimeterBorder) -> CGFloat {
        let horizontalCoefficient = viewSize.width / rectanglesPerimeterBorder.right
        let verticalCoefficient = viewSize.height / rectanglesPerimeterBorder.bottom
        
        return min(horizontalCoefficient, verticalCoefficient)
    }

    private func mapRectangle(
        _ rectangle: VMRectangle,
        coefficient: CGFloat,
        horizontalOffset: CGFloat,
        verticalOffset: CGFloat
    ) -> RectangleImage {
        
        let frame = CGRect(
            x: (rectangle.origin.x + horizontalOffset) * coefficient,
            y: (rectangle.origin.y + verticalOffset) * coefficient,
            width: rectangle.frame.width * coefficient,
            height: rectangle.frame.height * coefficient
        )
        
        return RectangleImage(
            id: rectangle.id,
            frame: frame
        )
    }
}
