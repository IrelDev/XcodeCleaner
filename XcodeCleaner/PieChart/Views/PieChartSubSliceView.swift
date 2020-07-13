//
//  PieChartSubSliceView.swift
//  PieChartSwiftUI
//
//  Created by Kirill Pustovalov on 28.06.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

struct PieChartSubSliceView: View {
    var rect: CGRect
    
    let subSlice: PieChartSubSliceModel
    @State var isVisible: Bool = false
    
    var body: some View {
        let startAngle = Angle(degrees: subSlice.startDegree)
        let endAngle = Angle(degrees: subSlice.endDegree)
        
        let sliceShape = PieChartSubSliceShape(startAngle: startAngle, endAngle: endAngle)
        
        return Group { sliceShape
            .fill()
            .foregroundColor(subSlice.color)
            .scaleEffect(isVisible ? 1: 0)
            .animation(Animation.easeIn)
            .onAppear {
                self.isVisible.toggle()
            }
        }
    }
}

struct PieChartSubSliceView_Previews: PreviewProvider {
    static var previews: some View {
        let pieSlice = PieChartSubSliceModel(value: .zero, color: .orange, startDegree: 50, endDegree: 130)
        
        return GeometryReader { geometryReader in
            PieChartSubSliceView(rect: geometryReader.frame(in: .local), subSlice: pieSlice)
        }
        .frame(width: 150, height: 150)
    }
}
