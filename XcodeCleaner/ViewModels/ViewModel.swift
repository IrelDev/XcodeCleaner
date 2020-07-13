//
//  ViewModel.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 05.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject, ViewModelProtocol {
    private let directoryManager = DirectoryManager()
    
    @Published var isScanStarted = false
    
    @Published var directoriesCount: Int = 0
    @Published var analyzedDirectoriesCount: Int = 0
    @Published var totalSize: Int64 = 0
    
    @Published var derivedData: [DirectoryModel] = []
    @Published var deviceSupport: [DirectoryModel] = []
    @Published var archives: [DirectoryModel] = []
    @Published var iOSDeviceLogs: [DirectoryModel] = []
    @Published var documentationCache: [DirectoryModel] = []
    
    @Published var isReadyToBeCleaned = false
    @Published var isCleanStarted = false
    
    @Published var isAlertPresented = false
    
    var scanProgress: Double {
        directoriesCount == 0 ? 0: Double(analyzedDirectoriesCount) / Double(directoriesCount)
    }
    func startScan() {
        guard !isScanStarted else { return }
        isScanStarted.toggle()
        
        cleanBeforeScan()
        
        let derivedDataDirectories = directoryManager.getSubDirectoriesForPath(path: directoryManager.getDerivedDataPath())
        directoriesCount += derivedDataDirectories.count
        
        let deviceSupportDirectories = directoryManager.getSubDirectoriesForPath(path: directoryManager.getDeviceSupportPath())
        directoriesCount += deviceSupportDirectories.count
        
        let archivesDirectories = directoryManager.getSubDirectoriesForPath(path: directoryManager.getArchivesPath())
        directoriesCount += archivesDirectories.count
        
        let iOSDeviceLogsDirectories = directoryManager.getSubDirectoriesForPath(path: directoryManager.getIOSDeviceLogsPath())
        directoriesCount += iOSDeviceLogsDirectories.count
        
        let documentationCacheDirectories = directoryManager.getSubDirectoriesForPath(path: directoryManager.getDocumentationCachePath())
        directoriesCount += documentationCacheDirectories.count
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.calculateSize(ofDirectory: &self.derivedData, subDirectories: derivedDataDirectories, type: .derivedData)
            self.calculateSize(ofDirectory: &self.deviceSupport, subDirectories: deviceSupportDirectories, type: .deviceSupport)
            self.calculateSize(ofDirectory: &self.archives, subDirectories: archivesDirectories, type: .archives)
            self.calculateSize(ofDirectory: &self.iOSDeviceLogs, subDirectories: iOSDeviceLogsDirectories, type: .iOSDeviceLogs)
            self.calculateSize(ofDirectory: &self.documentationCache, subDirectories: documentationCacheDirectories, type: .documentationCache)
            
            self.isScanStarted.toggle()
            self.isReadyToBeCleaned.toggle()
            
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    func calculateSize(ofDirectory: inout [DirectoryModel], subDirectories: [String], type: DirectoryType) {
        ofDirectory = subDirectories.map { path in
            let directorySize = self.directoryManager.getSize(path: path) {
                self.analyzedDirectoriesCount += 1
            }
            
            DispatchQueue.main.async {
                self.totalSize += directorySize
                self.objectWillChange.send()
            }
            let normalizedDirectoryPathForDisplay = directoryManager.normalizePathForDisplay(directory: path, forType: type)
            
            return DirectoryModel(name: normalizedDirectoryPathForDisplay, size: directorySize)
        }
    }
    func getViewModelForItemList(forType type: DirectoryType) -> DirectoryListViewModelProtocol {
        var directoryName: String
        var directories: [DirectoryModel]
        var circleColor: Color
        
        switch type {
        case .derivedData:
            directories = derivedData
            directoryName = "Derived Data"
            circleColor = .pink
        case .deviceSupport:
            directories = deviceSupport
            directoryName = "Device Support"
            circleColor = Color(.cyan)
        case .archives:
            directories = archives
            directoryName = "Archives"
            circleColor = .orange
        case .iOSDeviceLogs:
            directories = iOSDeviceLogs
            directoryName = "Device Logs"
            circleColor = .purple
        case .documentationCache:
            directories = documentationCache
            directoryName = "Doc. Cache"
            circleColor = .gray
        }
        
        var viewModel = DirectoryListViewModel(directoryName: directoryName, directories: directories, circleColor: circleColor)
        viewModel.calculateTotalSize()
        
        return viewModel
    }
    func cleanBeforeScan() {
        directoriesCount = 0
        analyzedDirectoriesCount = 0
        totalSize = 0
        
        derivedData.removeAll()
        deviceSupport.removeAll()
        archives.removeAll()
        iOSDeviceLogs.removeAll()
        documentationCache.removeAll()
        
        objectWillChange.send()
    }
    func getViewModelForPieChart() -> PieChartViewModelProtocol {
        var viewModel = PieChartViewModel()
        viewModel.createItems(derivedData: derivedData, deviceSupport: deviceSupport, archives: archives, iOSDeviceLogs: iOSDeviceLogs, documentationCache: documentationCache)
        
        return viewModel
    }
    //add chosen type
    func startClean() {
        guard !isCleanStarted else { return }
        isCleanStarted.toggle()
        objectWillChange.send()
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.directoryManager.cleanDirectory(forType: .derivedData)
            self.directoryManager.cleanDirectory(forType: .deviceSupport)
            self.directoryManager.cleanDirectory(forType: .archives)
            self.directoryManager.cleanDirectory(forType: .iOSDeviceLogs)
            self.directoryManager.cleanDirectory(forType: .documentationCache)
            
            DispatchQueue.main.async {
                let statistic = StatisticModel(totalCleaned: self.totalSize, lastTimeCleaned: DateManager.getCurrentDate())
                
                CoreDataManager.shared.saveStatistic(statistic: statistic)
                
                self.isAlertPresented.toggle()
                self.isCleanStarted.toggle()
                self.objectWillChange.send()
                
                self.isReadyToBeCleaned.toggle()
            }
        }
    }
    func getViewModelForStatistic() -> StatisticViewModelProtocol {
        let statistic = CoreDataManager.shared.getStatistic()
        let viewModel = StatisticViewModel(statistic: statistic)
        
        return viewModel
    }
}
