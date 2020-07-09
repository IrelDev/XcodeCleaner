//
//  PieChartAnySliceProtocol.swift
//  PieChartSwiftUI
//
//  Created by Kirill Pustovalov on 28.06.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

protocol PieChartAnySliceProtocol {
    var value: Double { get set }
    var color: Color { get set }
    
    var startDegree: Double { get set }
    var endDegree: Double { get set }
}

