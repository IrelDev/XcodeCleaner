//
//  PieChartSliceFactory.swift
//  PieChartSwiftUI
//
//  Created by Kirill Pustovalov on 28.06.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

class PieChartSliceFactory {
    func createPieChartSlicesFromItems(items: [PieChartItemModel], maxShapeDegree: Double, initialDegree: Double = 0.0) -> [PieChartSliceModel] {
        var slices: [PieChartSliceModel] = []
        var previousSliceEndDegree = initialDegree
        
        let maxSumSliceValue = items.reduce(0) { $0 + $1.value }
        
        for itemIndex in 0 ..< items.count {
            let item = items[itemIndex]
            
            let sliceStartDegree = previousSliceEndDegree
            let proportionalValue = item.value / maxSumSliceValue
            
            let sliceEndDegree = sliceStartDegree + proportionalValue * maxShapeDegree
            
            let slice = PieChartSliceModel(value: item.value, color: item.color, startDegree: sliceStartDegree, endDegree: sliceEndDegree)
            slices.append(slice)
            
            previousSliceEndDegree = sliceEndDegree
        }
        return slices
    }
}
