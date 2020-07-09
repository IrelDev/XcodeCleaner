//
//  PieChartViewModel.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 07.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

struct PieChartViewModel: PieChartViewModelProtocol {
    var items: [PieChartItemModel] = []
    
    mutating func createItems(derivedData: [DirectoryModel], deviceSupport: [DirectoryModel], archives: [DirectoryModel]) {
        var derivedDataSize: Int64 = 0
        derivedData.forEach {
            derivedDataSize += $0.size
        }
        
        var deviceSupportSize: Int64 = 0
        deviceSupport.forEach {
            deviceSupportSize += $0.size
        }
        
        var archivesSize: Int64 = 0
        archives.forEach {
            archivesSize += $0.size
        }
        
        var derivedData: PieChartItemModel
        var deviceSupport: PieChartItemModel
        var archives: PieChartItemModel
        
        if derivedDataSize == 0 && deviceSupportSize == 0 && archivesSize == 0 {
            let defaultValue = 1.0
            
            derivedData = PieChartItemModel(value: defaultValue, color: .pink)
            deviceSupport = PieChartItemModel(value: defaultValue, color: Color(.cyan))
            archives = PieChartItemModel(value: defaultValue, color: .orange)
            
            let items = [archives, deviceSupport, derivedData]
            self.items = items
        } else {
            derivedData = PieChartItemModel(value: Double(derivedDataSize), color: .pink)
            deviceSupport = PieChartItemModel(value: Double(deviceSupportSize), color: Color(.cyan))
            archives = PieChartItemModel(value: Double(archivesSize), color: .orange)

            let items = [archives, deviceSupport, derivedData]
            
            var normalizedItems: [PieChartItemModel] = []
            
            items.forEach {
                if $0.value != 0 {
                    normalizedItems.append($0)
                }
            }
            self.items = normalizedItems
        }
    }
    func getPCItems() -> PCItems {
        let pcItems = PCItems(items: [])
        
        items.forEach { item in
                pcItems.items.append(item)
        }
        return pcItems
    }
}
