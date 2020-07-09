//
//  PieChartSliceShape.swift
//  PieChartSwiftUI
//
//  Created by Kirill Pustovalov on 28.06.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

struct PieChartSliceShape: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let size = min(rect.width / 2, rect.height / 2)
        
        let radius = size
        
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.addLine(to: center)
        
        path.closeSubpath()
        
        return path
    }
}

struct PieChartSliceShape_Previews: PreviewProvider {
    static var previews: some View {
        let startAngle = Angle(degrees: 0)
        let endAngle = Angle(degrees: 90)
        
        return PieChartSliceShape(startAngle: startAngle, endAngle: endAngle)
            .fill()
            .foregroundColor(.orange)
            .frame(width: 150, height: 150)
    }
}

