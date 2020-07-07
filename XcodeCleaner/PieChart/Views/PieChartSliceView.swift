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
    let sliceSeparatorColor: Color
    
    @State var isVisible: Bool = false
    
    var body: some View {
        let startAngle = Angle(degrees: slice.startDegree)
        let endAngle = Angle(degrees: slice.endDegree)
        
        let sliceShape = PieChartSliceShape(startAngle: startAngle, endAngle: endAngle)
        
        return Group { sliceShape
            .fill()
            .overlay(sliceShape.stroke(sliceSeparatorColor, lineWidth: 2))
            .foregroundColor(slice.color)
            .scaleEffect(isVisible ? 1: 0)
            .animation(Animation.easeIn)
            .onAppear {
                self.isVisible.toggle()
            }
            if self.slice.subSlices.count > 0 {
                GeometryReader { geometryReader in
                    ForEach(0 ..< self.slice.subSlices.count, id: \.self) { subSliceIndex in
                        PieChartSubSliceView(rect: geometryReader.frame(in: .local), subSlice: self.slice.subSlices[subSliceIndex], sliceSeparatorColor: self.sliceSeparatorColor)
                            .padding(0 - min(geometryReader.size.width, geometryReader.size.height) / 2)
                    }
                }
            }
        }
    }
}

struct PieSliceView_Previews: PreviewProvider {
    static var previews: some View {
        let pieSlice = PieChartSliceModel(value: .zero, color: .orange, startDegree: 50, endDegree: 130)
        let sliceSeparatorColor = Color.black
        
        return GeometryReader { geometryReader in
            PieChartSliceView(rect: geometryReader.frame(in: .local), slice: pieSlice, sliceSeparatorColor: sliceSeparatorColor)
        }
        .frame(width: 150, height: 150)
    }
}

