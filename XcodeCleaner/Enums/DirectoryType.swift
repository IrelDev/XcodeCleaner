//
//  DirectoryType.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 05.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

public enum DirectoryType: String, CaseIterable {
    case derivedData
    case iOSDeviceSupport
    case watchOSDeviceSupport
    case documentationCache
    case archives
    case iOSDeviceLogs
}
