//
//  DateManager.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 08.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import Foundation

struct DateManager {
    static func getCurrentDate() -> Date {
        Date()
    }
    static func getStringDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
}
