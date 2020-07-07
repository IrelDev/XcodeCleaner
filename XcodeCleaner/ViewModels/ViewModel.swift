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
    
    var scanProgress: Double {
        directoriesCount == 0 ? 0: Double(analyzedDirectoriesCount) / Double(directoriesCount)
    }
    func startScan() {
        guard !isScanStarted else { return }
        cleanBeforeScan()
        objectWillChange.send()
        
        isScanStarted.toggle()
        
        let derivedDataDirectories = directoryManager.getSubDirectoriesForPath(path: directoryManager.getDerivedDataPath())
        directoriesCount += derivedDataDirectories.count
        
        let deviceSupportDirectories = directoryManager.getSubDirectoriesForPath(path: directoryManager.getDeviceSupportPath())
        directoriesCount += deviceSupportDirectories.count
        
        let archivesDirectories = directoryManager.getSubDirectoriesForPath(path: directoryManager.getArchivesPath())
        directoriesCount += archivesDirectories.count
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.calculateSize(ofDirectory: &self.derivedData, subDirectories: derivedDataDirectories, type: .derivedData)
            self.calculateSize(ofDirectory: &self.deviceSupport, subDirectories: deviceSupportDirectories, type: .deviceSupport)
            self.calculateSize(ofDirectory: &self.archives, subDirectories: archivesDirectories, type: .archives)
            
            self.isScanStarted.toggle()
            
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    func calculateSize(ofDirectory: inout [DirectoryModel], subDirectories: [String], type: DirectoryType) {
        ofDirectory = subDirectories.map { directory in
            let normalizedDirectoryPathForDisplay = self.directoryManager.normalizeDirectoryPathForDisplay(directory: directory, forType: type)
            let normalizedDirectoryPath = self.directoryManager.normalizeDirectoryPath(directory: directory)
            
            
            let directorySize = self.directoryManager.getDirectorySize(path: normalizedDirectoryPath) {
                self.analyzedDirectoriesCount += 1
            }
            
            DispatchQueue.main.async {
                self.totalSize += directorySize
                self.objectWillChange.send()
            }
            
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
    }
    func getViewModelForPieChart() -> PieChartViewModelProtocol {
        var viewModel = PieChartViewModel()
        viewModel.createItems(derivedData: derivedData, deviceSupport: deviceSupport, archives: archives)
        
        return viewModel
    }
}
