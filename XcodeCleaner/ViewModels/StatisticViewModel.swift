//
//  StatisticViewModel.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 06.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import Foundation

class StatisticViewModel: StatisticViewModelProtocol {
    var totalCleaned: Int64? = 0
    var lastTimeCleaned: Date? = Date()
}
