//
//  PieChartView.swift
//  PieChartSwiftUI
//
//  Created by Kirill Pustovalov on 28.06.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

public struct PieChartView: View {
    @ObservedObject var items: PCItems
    var sliceSeparatorColor: Color
    
    public init(items: PCItems, sliceSeparatorColor: Color = .white) {
        self.items = items
        self.sliceSeparatorColor = sliceSeparatorColor
    }
    
    public var body: some View {
        let sliceFactory = PieChartSliceFactory()
        let circleShapeMaxDegree = 360.0
        
        let slices = sliceFactory.createPieChartSlicesFromItems(items: items.items, maxShapeDegree: circleShapeMaxDegree)
        
        return Group {
            GeometryReader { geometryReader in
                if slices.count == 1 {
                    Circle()
                        .fill(slices.first!.color)
                        .overlay(Circle().stroke(self.sliceSeparatorColor, lineWidth: 1))
                        .frame(width: geometryReader.size.width, height: geometryReader.size.height)
                    
                    ForEach(0 ..< slices.first!.subSlices.count, id: \.self) { subSliceIndex in
                        PieChartSubSliceView(rect: geometryReader.frame(in: .local), subSlice: (slices.first!.subSlices[subSliceIndex]))
                    }
                } else {
                    ForEach(0 ..< slices.count, id: \.self) { sliceIndex in
                        PieChartSliceView(rect: geometryReader.frame(in: .local), slice: slices[sliceIndex])
                    }
                }
            }
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        let pieChartItemOne = PieChartItemModel(value: 25, color: .pink)
        let pieChartItemTwo = PieChartItemModel(value: 25, color: .orange)
        let pieChartItemThree = PieChartItemModel(value: 25, color: .red)
        
        let items = PCItems(items: [pieChartItemOne, pieChartItemTwo, pieChartItemThree])
        let itemsFromData = PCItems(data: [25, 50, 25], chartColor: .black)
        
        return VStack {
            Spacer()
            
            PieChartView(items: items, sliceSeparatorColor: .black)
                .frame(width: 100, height: 100, alignment: .center)
            Spacer()
            
            PieChartView(items: itemsFromData, sliceSeparatorColor: .white)
                .frame(width: 100, height: 100, alignment: .center)
            Spacer()
            
        }
    }
}
