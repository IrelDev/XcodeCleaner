//
//  DirectoryListViewModel.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 06.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

struct DirectoryListViewModel: DirectoryListViewModelProtocol {
    var directoryName: String
    var directories: [DirectoryModel]
    
    var totalSize: Int64 = 0
    var circleColor: Color
    
    mutating func calculateTotalSize() {
        var size: Int64 = 0
        
        directories.forEach { directory in
            size += directory.size
        }
        totalSize = size
    }
}
