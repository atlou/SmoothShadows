//
//  SmoothShadows.swift
//  SmoothShadows
//
//  Created by Xavier on 29/11/2024.
//

import SwiftUI

public extension View {
    func smoothShadow(color: Color = .black, x: Double = 0, y: Double = 8) -> some View {
        modifier(SmoothShadowModifier(color: color, x: x, y: y))
    }
}

public struct SmoothShadowModifier: ViewModifier {
    private struct ShadowLayer {
        let x: Double
        let y: Double
        let xOffset: Double
        let yOffset: Double
        let radius: CGFloat
        
        init(x: Double, y: Double, n: Int, xOffset: Double = 0, yOffset: Double = 0) {
            func deriveOffset(_ offset: Double, n: Int) -> Double {
                return Double((n * n)/4) * offset
            }
            
            self.x = deriveOffset(x, n: n) - xOffset
            self.y = deriveOffset(y, n: n) - yOffset
            self.xOffset = xOffset
            self.yOffset = yOffset
            self.radius = sqrt(y * y + x * x) * (0.5 + Double(n/4))
        }
    }
    
    private let color: Color
    
    private let l1: ShadowLayer
    private let l2: ShadowLayer
    private let l3: ShadowLayer
    private let l4: ShadowLayer
    private let l5: ShadowLayer
    
    init(color: Color = .black, x: Double = 0, y: Double = 0) {
        self.color = color
        let layers = SmoothShadowModifier.generateLayers(x: x, y: y)
        self.l1 = layers[0]
        self.l2 = layers[1]
        self.l3 = layers[2]
        self.l4 = layers[3]
        self.l5 = layers[4]
    }
    
    public func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(0.31), radius: l1.radius, x: l1.x, y: l1.y)
            .shadow(color: color.opacity(0.27), radius: l2.radius, x: l2.x, y: l2.y)
            .shadow(color: color.opacity(0.16), radius: l3.radius, x: l3.x, y: l3.y)
            .shadow(color: color.opacity(0.05), radius: l4.radius, x: l4.x, y: l4.y)
            .shadow(color: color.opacity(0.01), radius: l5.radius, x: l5.x, y: l5.y)
    }
    
    private static func generateLayers(x: Double, y: Double) -> [ShadowLayer] {
        let NUM_LAYERS = 5
        
        var layers: [ShadowLayer] = []
        for i in 0 ..< NUM_LAYERS {
            if i == 0 {
                layers.append(.init(x: x, y: y, n: 1))
            } else {
                let prev = layers[i - 1]
                layers.append(.init(x: x, y: y, n: i + 1, xOffset: prev.xOffset, yOffset: prev.yOffset))
            }
        }
        
        return layers
    }
}
