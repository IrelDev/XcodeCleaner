//
//  StatisticViewModel.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 06.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import Foundation

struct StatisticViewModel: StatisticViewModelProtocol {
    var statistic: StatisticModel
    
    func getLastDate() -> String {
        guard let date = statistic.lastTimeCleaned else { return "none" }
        return DateManager.getStringDate(date: date)
    }
    func getTotalSize() -> String {
        guard let size = statistic.totalCleaned else { return "none" }
        return BytesToStringFormatter.format(size: size)
    }
}
