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
    
    mutating func createItems(derivedData: [DirectoryModel], iOSDeviceSupport: [DirectoryModel], watchOSDeviceSupport: [DirectoryModel], archives: [DirectoryModel], iOSDeviceLogs: [DirectoryModel], documentationCache: [DirectoryModel]) {
        var derivedDataSize: Int64 = 0
        derivedData.forEach {
            derivedDataSize += $0.size
        }
        
        var iOSDeviceSupportSize: Int64 = 0
        iOSDeviceSupport.forEach {
            iOSDeviceSupportSize += $0.size
        }
        
        var watchOSDeviceSupportSize: Int64 = 0
        watchOSDeviceSupport.forEach {
            watchOSDeviceSupportSize += $0.size
        }
        
        var archivesSize: Int64 = 0
        archives.forEach {
            archivesSize += $0.size
        }
        
        var iOSDeviceLogsSize: Int64 = 0
        iOSDeviceLogs.forEach {
            iOSDeviceLogsSize += $0.size
        }
        
        var documentationCacheSize: Int64 = 0
        documentationCache.forEach {
            documentationCacheSize += $0.size
        }
        
        var derivedData: PieChartItemModel
        var iOSDeviceSupport: PieChartItemModel
        var watchOSDeviceSupport: PieChartItemModel
        var archives: PieChartItemModel
        var iOSDeviceLogs: PieChartItemModel
        var documentationCache: PieChartItemModel
        
        if derivedDataSize == 0 && iOSDeviceSupportSize == 0 && archivesSize == 0 && iOSDeviceLogsSize == 0 && watchOSDeviceSupportSize == 0 && documentationCacheSize == 0 {
            let defaultValue = 1.0
            
            derivedData = PieChartItemModel(value: defaultValue, color: .pink)
            iOSDeviceSupport = PieChartItemModel(value: defaultValue, color: Color(.cyan))
            archives = PieChartItemModel(value: defaultValue, color: .orange)
            
            let items = [archives, iOSDeviceSupport, derivedData]
            self.items = items
        } else {
            derivedData = PieChartItemModel(value: Double(derivedDataSize), color: .pink)
            iOSDeviceSupport = PieChartItemModel(value: Double(iOSDeviceSupportSize), color: Color(.cyan))
            watchOSDeviceSupport = PieChartItemModel(value: Double(watchOSDeviceSupportSize), color: .green)
            archives = PieChartItemModel(value: Double(archivesSize), color: .orange)
            iOSDeviceLogs = PieChartItemModel(value: Double(iOSDeviceLogsSize), color: .purple)
            documentationCache = PieChartItemModel(value: Double(documentationCacheSize), color: .gray)

            let items = [archives, iOSDeviceSupport, watchOSDeviceSupport, derivedData, iOSDeviceLogs, documentationCache]
            
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
