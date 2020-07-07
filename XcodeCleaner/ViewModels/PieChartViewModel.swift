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
        var derivedDataSize: Int64 = 1
        derivedData.forEach {
            derivedDataSize += $0.size
        }
        
        let derivedData = PieChartItemModel(value: Double(derivedDataSize), color: .pink)
        
        var deviceSupportSize: Int64 = 1
        deviceSupport.forEach {
            deviceSupportSize += $0.size
        }
        
        let deviceSupport = PieChartItemModel(value: Double(deviceSupportSize), color: Color(.cyan))
        
        var archivesSize: Int64 = 1
        archives.forEach {
            archivesSize += $0.size
        }
        
        let archives = PieChartItemModel(value: Double(archivesSize), color: .orange)
        
        let items = [archives, deviceSupport, derivedData]
        self.items = items
    }
    
    func getPCItems() -> PCItems {
        let pcItems = PCItems(items: [])
        
        items.forEach { item in
            if item.value != 0 {
                pcItems.items.append(item)
            }
        }
        return pcItems
    }
}
