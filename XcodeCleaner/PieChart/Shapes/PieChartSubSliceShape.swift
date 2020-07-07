//
//  PieChartSubSliceShape.swift
//  PieChartSwiftUI
//
//  Created by Kirill Pustovalov on 28.06.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

struct PieChartSubSliceShape: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let size = min(rect.width / 2, rect.height / 2)
        
        let firstRadius = size
        let secondRadius = size / 2
        
        path.addArc(center: center, radius: firstRadius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.addArc(center: center, radius: secondRadius, startAngle: endAngle, endAngle: startAngle, clockwise: true)
        path.closeSubpath()
        
        return path
    }
}

struct PieChartSubSliceShape_Previews: PreviewProvider {
    static var previews: some View {
        let startAngle = Angle(degrees: 0)
        let endAngle = Angle(degrees: 90)
        
        return PieChartSubSliceShape(startAngle: startAngle, endAngle: endAngle)
            .fill()
            .foregroundColor(.orange)
            .frame(width: 150, height: 150)
    }
}
