//
//  ViewModelProtocol.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 06.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import Foundation

protocol ViewModelProtocol {
    var isScanStarted: Bool { get set }
    
    var directoriesCount: Int { get set }
    var analyzedDirectoriesCount: Int { get set }
    var totalSize: Int64 { get set }
    
    var derivedData: [DirectoryModel] { get set }
    var deviceSupport: [DirectoryModel] { get set }
    var archives: [DirectoryModel] { get set }
    
    var scanProgress: Double { get }
    
    func startScan()
    func calculateSize(ofDirectory: inout [DirectoryModel], subDirectories: [String], type: DirectoryType)
    func getViewModelForItemList(forType type: DirectoryType) -> DirectoryListViewModelProtocol
    func cleanBeforeScan()
    func getViewModelForPieChart() -> PieChartViewModelProtocol
}
