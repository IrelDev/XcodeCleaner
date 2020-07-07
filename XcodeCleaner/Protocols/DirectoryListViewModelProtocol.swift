//
//  DirectoryListViewModelProtocol.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 06.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

protocol DirectoryListViewModelProtocol {
    var directoryName: String { get set }
    var totalSize: Int64 { get set }
    var directories: [DirectoryModel] { get set }
    var circleColor: Color { get set }
    
    mutating func calculateTotalSize()
}
