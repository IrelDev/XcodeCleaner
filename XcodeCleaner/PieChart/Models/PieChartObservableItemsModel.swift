//
//  PieChartObservableItemsModel.swift
//  PieChartSwiftUI
//
//  Created by Kirill Pustovalov on 28.06.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

public class PCItems: ObservableObject {
    @Published public var items: [PieChartItemModel]
    public init(items: [PieChartItemModel]) {
        self.items = items
    }
    public init(data: [Double], chartColor: Color) {
        self.items = data.map {
            PieChartItemModel(value: $0, color: chartColor)
        }
    }
}
