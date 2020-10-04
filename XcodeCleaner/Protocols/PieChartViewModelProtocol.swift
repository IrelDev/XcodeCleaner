//
//  PieChartViewModelProtocol.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 07.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import Foundation

protocol PieChartViewModelProtocol {
    var items: [PieChartItemModel] { get set }
    
    mutating func createItems(derivedData: [DirectoryModel], iOSDeviceSupport: [DirectoryModel], watchOSDeviceSupport: [DirectoryModel], archives: [DirectoryModel], iOSDeviceLogs: [DirectoryModel], documentationCache: [DirectoryModel])
    func getPCItems() -> PCItems
}
