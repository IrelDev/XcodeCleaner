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
    
    public init(items: PCItems) {
        self.items = items
    }
    
    public var body: some View {
        let sliceFactory = PieChartSliceFactory()
        let circleShapeMaxDegree = 360.0
        
        let slices = sliceFactory.createPieChartSlicesFromItems(items: items.items, maxShapeDegree: circleShapeMaxDegree)
        
        return Group {
            GeometryReader { geometryReader in
                ForEach(0 ..< slices.count, id: \.self) { sliceIndex in
                    PieChartSliceView(rect: geometryReader.frame(in: .local), slice: slices[sliceIndex])
                }
                .overlay(Circle().stroke(Color(NSColor.labelColor), lineWidth: 1))
                .frame(width: geometryReader.size.width, height: geometryReader.size.height)
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
            
            PieChartView(items: items)
                .frame(width: 100, height: 100, alignment: .center)
            Spacer()
            
            PieChartView(items: itemsFromData)
                .frame(width: 100, height: 100, alignment: .center)
            Spacer()
            
        }
    }
}
