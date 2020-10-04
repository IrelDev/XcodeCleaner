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
    func getIOSDeviceSupportPath() -> String {
        let xcodePath = getXcodeDefaultPath()
        let deviceSupportPath = "iOS DeviceSupport/"
        return "\(xcodePath + deviceSupportPath)"
    }
    func getWatchOSDeviceSupportPath() -> String {
        let xcodePath = getXcodeDefaultPath()
        let watchOSDeviceSupport = "watchOS DeviceSupport/"
        return "\(xcodePath + watchOSDeviceSupport)"
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
    func getFileType(path: String) -> FileType? {
        let fileManager = FileManager.default        
        var isDirectory: ObjCBool = false
        
        if fileManager.fileExists(atPath: path, isDirectory: &isDirectory) {
            if isDirectory.boolValue {
                return .directory
            } else {
                return .file
            }
        }
        return nil
    }
    func getSize(path: String, completion: () -> Void = { }) -> Int64 {
        let fileManager = FileManager.default
        var directorySize: Int64 = 0
        
        var normalizedPath: String
        let fileType = getFileType(path: path)
        
        switch fileType {
        case .directory:
            normalizedPath = normalizePathForDirectory(path: path)
        case .file:
            normalizedPath = normalizePathForFile(path: path)
        case .none:
            return 0
        }
        
        if fileType == .file {
            do {
                let attributes = try fileManager.attributesOfItem(atPath: normalizedPath)
                directorySize += attributes[FileAttributeKey.size] as! Int64
            } catch {
                print(error.localizedDescription)
            }
        } else {
            let directories = fileManager.subpaths(atPath: normalizedPath)
            
            for directory in directories! {
                do {
                    let newPath = normalizedPath + directory
                    let attributes = try fileManager.attributesOfItem(atPath: newPath)
                    directorySize += attributes[FileAttributeKey.size] as! Int64
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        completion()
        return directorySize
    }
    func getPath(for type: DirectoryType) -> String {
        var path: String
        
        switch type {
        case .derivedData:
            path = getDerivedDataPath()
        case .iOSDeviceSupport:
            path = getIOSDeviceSupportPath()
        case .watchOSDeviceSupport:
            path = getWatchOSDeviceSupportPath()
        case .archives:
            path = getArchivesPath()
        case .iOSDeviceLogs:
            path = getIOSDeviceLogsPath()
        case .documentationCache:
            path = getDocumentationCachePath()
        }
        return path
    }
    func normalizePathForDirectory(path: String) -> String {
        var newPath = path
        
        if !newPath.hasSuffix("/") {
            newPath += "/"
        }
        return newPath
    }
    func normalizePathForFile(path: String) -> String {
        var newPath = path
        
        if newPath.hasSuffix("/") {
            newPath.removeLast()
        }
        return newPath
    }
    func normalizePathForDisplay(directory: String, forType type: DirectoryType) -> String {
        var result = directory
        let prefix: String = getPath(for: type)
        
        if directory.contains(prefix) {
            result = directory.replacingOccurrences(of: prefix, with: "")
        }
        
        return result
    }
    func cleanDirectory(forType type: DirectoryType) {
        let fileManager = FileManager.default
        let directoryPath = getPath(for: type)
        let directoryURL = URL(fileURLWithPath: normalizePathForDirectory(path: directoryPath))
        
        do {
            try fileManager.removeItem(at: directoryURL)
        } catch {
            print(error.localizedDescription)
        }
    }
}
