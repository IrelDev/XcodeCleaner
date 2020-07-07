//
//  PieChartItemModel.swift
//  PieChartSwiftUI
//
//  Created by Kirill Pustovalov on 28.06.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

public struct PieChartItemModel {
    public var value: Double
    public var color: Color
    public var subItems: [PieChartItemModel]
    
    public init(value: Double, color: Color, subItems: [PieChartItemModel] = []) {
        self.value = value
        self.color = color
        
        self.subItems = subItems
    }
}
