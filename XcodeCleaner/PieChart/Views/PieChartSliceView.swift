//
//  PieChartSliceView.swift
//  PieChartSwiftUI
//
//  Created by Kirill Pustovalov on 28.06.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

struct PieChartSliceView: View {
    var rect: CGRect
    
    let slice: PieChartSliceModel
    
    @State var isVisible: Bool = false
    
    var body: some View {
        let startAngle = Angle(degrees: slice.startDegree)
        let endAngle = Angle(degrees: slice.endDegree)
        
        let sliceShape = PieChartSliceShape(startAngle: startAngle, endAngle: endAngle)
        
        return sliceShape
            .fill()
            .foregroundColor(slice.color)
            .scaleEffect(isVisible ? 1: 0.01)
            .animation(Animation.easeIn)
            .onAppear {
                self.isVisible.toggle()
        }
    }
}

struct PieSliceView_Previews: PreviewProvider {
    static var previews: some View {
        let pieSlice = PieChartSliceModel(value: .zero, color: .orange, startDegree: 50, endDegree: 130)        
        return GeometryReader { geometryReader in
            PieChartSliceView(rect: geometryReader.frame(in: .local), slice: pieSlice)
        }
        .frame(width: 150, height: 150)
    }
}

