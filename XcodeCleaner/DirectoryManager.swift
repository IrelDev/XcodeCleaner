//
//  DirectoryManager.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 04.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import Cocoa

struct DirectoryManager {
    func getValidHomeDirectory() -> String {
        var homeDirectory = NSHomeDirectory()
        let prefix = "/Library/Containers/"
        
        if homeDirectory.contains(prefix) {
            if let range = homeDirectory.range(of: prefix) {
                homeDirectory = String(homeDirectory[..<range.lowerBound])
            }
        }
        return homeDirectory
    }
    func getXcodeDefaultPath() -> String {
        let homeDirectory = getValidHomeDirectory()
        let xcodePath = "/Library/Developer/Xcode/"
        return "\(homeDirectory + xcodePath)"
    }
    func getDerivedDataPath() -> String {
        let xcodePath = getXcodeDefaultPath()
        let derivedDataPath = "DerivedData/"
        return "\(xcodePath + derivedDataPath)"
    }
    func getDeviceSupportPath() -> String {
        let xcodePath = getXcodeDefaultPath()
        let deviceSupportPath = "iOS DeviceSupport/"
        return "\(xcodePath + deviceSupportPath)"
    }
    func getArchivesPath() -> String {
        let xcodePath = getXcodeDefaultPath()
        let archivesPath = "Archives/"
        return "\(xcodePath + archivesPath)"
    }
    func getIOSDeviceLogsPath() -> String {
        let xcodePath = getXcodeDefaultPath()
        let iOSDeviceLogsPath = "iOS Device Logs/"
        return "\(xcodePath + iOSDeviceLogsPath)"
    }
    func getDocumentationCachePath() -> String {
        let xcodePath = getXcodeDefaultPath()
        let documentationCachePath = "DocumentationCache/"
        return "\(xcodePath + documentationCachePath)"
    }
    func getSubDirectoriesForPath(path: String) -> [String] {
        let fileManager = FileManager.default
        
        var subDirectories: [String] = []
        do {
            let directories = try fileManager.contentsOfDirectory(atPath: path)
            
            for directory in directories {
                let subDirectoryPath = path + directory
                subDirectories.append(subDirectoryPath)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return subDirectories
    }
    func getDirectorySize(path: String, completion: @escaping () -> Void = { }) -> Int64 {
        let fileManager = FileManager.default
        var directorySize: Int64 = 0
        
        let directories = fileManager.subpaths(atPath: path)
        guard directories != nil else {
            completion()
            return 0 
        }
        
        for directory in directories! {
            do {
                let attributes = try fileManager.attributesOfItem(atPath: path + directory)
                directorySize += attributes[FileAttributeKey.size] as! Int64
            } catch {
                print(error.localizedDescription)
            }
        }
        completion()
        return directorySize
    }
    func normalizeDirectoryPath(directory: String) -> String {
        var newDirectoryPath = directory
        
        if !newDirectoryPath.hasSuffix("/") {
            newDirectoryPath += "/"
        }
        return newDirectoryPath
    }
    func normalizeDirectoryPathForDisplay(directory: String, forType type: DirectoryType) -> String {
        var result = directory
        var prefix: String
        
        switch type {
        case .derivedData:
            prefix = getDerivedDataPath()
        case .deviceSupport:
            prefix = getDeviceSupportPath()
        case .archives:
            prefix = getArchivesPath()
        case .iOSDeviceLogs:
            prefix = getIOSDeviceLogsPath()
        case .documentationCache:
            prefix = getDocumentationCachePath()
        }
        
        if directory.contains(prefix) {
            result = directory.replacingOccurrences(of: prefix, with: "")
        }
        
        return result
    }
    func cleanDirectory(forType type: DirectoryType) {
        let fileManager = FileManager.default
        
        var directoryPath: String
        switch type {
        case .derivedData:
            directoryPath = getDerivedDataPath()
        case .deviceSupport:
            directoryPath = getDeviceSupportPath()
        case .archives:
            directoryPath = getArchivesPath()
        case .iOSDeviceLogs:
            directoryPath = getIOSDeviceLogsPath()
        case .documentationCache:
            directoryPath = getDocumentationCachePath()
        }
        
        let directoryURL = URL(fileURLWithPath: normalizeDirectoryPath(directory: directoryPath))
        
        do {
            try fileManager.removeItem(at: directoryURL)
        } catch {
            print(error.localizedDescription)
        }
    }
}
