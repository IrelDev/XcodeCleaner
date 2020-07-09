//
//  PieChartSliceModel.swift
//  PieChartSwiftUI
//
//  Created by Kirill Pustovalov on 28.06.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

struct PieChartSliceModel: PieChartAnySliceProtocol {
    var value: Double
    var color: Color
    
    var startDegree: Double
    var endDegree: Double
    
    var subSlices: [PieChartSubSliceModel]
    
    public init(value: Double, color: Color, startDegree: Double, endDegree: Double, subSlices: [PieChartSubSliceModel] = []) {
        self.value = value
        self.color = color
        
        self.startDegree = startDegree
        self.endDegree = endDegree
        self.subSlices = subSlices
    }
}

