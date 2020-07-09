//
//  BytesToStringFormatter.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 06.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import Foundation

struct BytesToStringFormatter {
    static func format(size: Int64, allowedUnits: ByteCountFormatter.Units =  [.useGB, .useMB]) -> String {
        let byteCountFormatter = ByteCountFormatter()
        byteCountFormatter.allowedUnits = allowedUnits
        
        return byteCountFormatter.string(fromByteCount: size)
    }
}
